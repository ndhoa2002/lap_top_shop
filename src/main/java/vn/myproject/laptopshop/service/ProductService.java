package vn.myproject.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.myproject.laptopshop.domain.Cart;
import vn.myproject.laptopshop.domain.CartDetail;
import vn.myproject.laptopshop.domain.Product;
import vn.myproject.laptopshop.domain.Role;
import vn.myproject.laptopshop.domain.User;
import vn.myproject.laptopshop.repository.CartDetailRepository;
import vn.myproject.laptopshop.repository.CartRepository;
import vn.myproject.laptopshop.repository.ProductRepository;
import vn.myproject.laptopshop.repository.RoleRepository;
import vn.myproject.laptopshop.repository.UserRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;

    public ProductService(ProductRepository productRepository,
            CartRepository cartRepository, CartDetailRepository cartDetailRepository,
            UserService userService) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
    }

    public Page<Product> getAllProducts(int page, int size, Specification<Product> spec) {

        Pageable pageable = PageRequest.of(page, size);
        return this.productRepository.findAll(spec, pageable);
    }

    public Product handleSaveProduct(Product product) {
        return this.productRepository.save(product);
    }

    public Product getProductById(long id) {
        return this.productRepository.findById(id).get();
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    public List<CartDetail> getAllCartDetail(long cartId) {
        Cart cart = this.cartRepository.findById(cartId).get();
        return this.cartDetailRepository.findAllByCart(cart);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, int quantity) {

        User user = this.userService.getUserByEmail(email);

        double totalPrice = 0;
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);

            if (cart == null) {
                Cart otheCart = new Cart();
                otheCart.setUser(user);
                otheCart.setSum(0);
                otheCart.setTotalPrice(0);
                cart = this.cartRepository.save(otheCart);
            }

            Optional<Product> producOptional = this.productRepository.findById(productId);
            if (producOptional.isPresent()) {
                Product realProduct = producOptional.get();

                // check sản phẩm đã từng được thêm vào giỏ hàng trước đây chưa ?

                CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);

                if (oldDetail == null) {
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setProduct(realProduct);
                    cartDetail.setPrice(realProduct.getPrice());

                    cartDetail.setQuantity(quantity);

                    cartDetail.setTotal(cartDetail.getQuantity() * cartDetail.getPrice());
                    this.cartDetailRepository.save(cartDetail);

                    // update cart(sum)
                    int s = cart.getSum() + 1;
                    cart.setSum(s);
                    cart.setTotalPrice(cart.getTotalPrice() + cartDetail.getTotal());
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", s);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                    oldDetail.setTotal(oldDetail.getQuantity() * oldDetail.getPrice());
                    cart.setTotalPrice(cart.getTotalPrice() + (oldDetail.getPrice() * quantity));

                    this.cartRepository.save(cart);
                    this.cartDetailRepository.save(oldDetail);
                }
            }
        }
    }
}
