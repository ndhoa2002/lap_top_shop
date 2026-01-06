package vn.hoidanit.laptopshop.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.common.OrderStatus;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.OrderDTO;
import vn.hoidanit.laptopshop.domain.dto.OrderDetailDTO;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class OrderService {

    private final UserRepository userRepository;
    private final UserService userService;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;

    public OrderService(UserRepository userRepository, UserService userService, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository, ProductRepository productRepository) {
        this.userRepository = userRepository;
        this.userService = userService;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.productRepository = productRepository;
    }

    public Page<Order> getAllOrders(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findAll(pageable);
    }

    public List<CartDetail> getCartDetails(String email) {
        // TODO Auto-generated method stub
        User user = userService.getUserByEmail(email);
        List<CartDetail> currenCartDetails = new ArrayList<>();

        if (user != null) {
            Cart cart = cartRepository.findByUser(user);
            List<CartDetail> cartDetails = cartDetailRepository.findAllByCart(cart);
            currenCartDetails = cartDetails;

        }
        return currenCartDetails;

    }

    public void hanleSaveOrder(String email, OrderDTO orderDTO, HttpSession session) {
        // TODO Auto-generated method stub
        User user = userService.getUserByEmail(email);
        List<OrderDetail> orderDetails = new ArrayList<>();
        Date date = new Date();

        if (user != null) {
            Cart cart = cartRepository.findByUser(user);

            Order order = new Order();
            order.setFullName(orderDTO.getFirstName() + " " + orderDTO.getLastName());
            order.setAddress(orderDTO.getHouseNumber() + ", " + orderDTO.getWard() + ", " + orderDTO.getTown() + ", "
                    + orderDTO.getProvince());
            order.setEmail(orderDTO.getEmail());
            order.setPhone(orderDTO.getPhone());
            order.setNote(orderDTO.getNote());
            order.setTotalPrice(cart.getTotalPrice());
            order.setStatus(OrderStatus.PENDING);
            order.setOrderDate(date);
            order.setUser(user);
            orderRepository.save(order);

            List<CartDetail> cartDetails = cartDetailRepository.findAllByCart(cart);
            for (CartDetail cartDetail : cartDetails) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setProduct(cartDetail.getProduct());
                orderDetail.setPrice(cartDetail.getPrice());
                orderDetail.setQuantity(cartDetail.getQuantity());
                orderDetail.setTotal(cartDetail.getTotal());
                orderDetail.setOrder(order);
                orderDetailRepository.save(orderDetail);
            }

            for (CartDetail cartDetail : cartDetails) {
                cartDetailRepository.delete(cartDetail);
            }

            cart.setSum(0);
            cart.setTotalPrice(0);
            session.setAttribute("sum", cart.getSum());
            cartRepository.save(cart);
        }
    }

    public void updateStatus(Long id, OrderStatus status) {
        // TODO Auto-generated method stub
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(status);
        orderRepository.save(order);
        if (status == OrderStatus.COMPLETED) {
            List<OrderDetail> orderDetails = orderDetailRepository.findByOrder(order);
            for (OrderDetail orderDetail : orderDetails) {
                Product product = orderDetail.getProduct();
                product.setQuantity(product.getQuantity() - orderDetail.getQuantity());
                product.setSold(product.getSold() + orderDetail.getQuantity());
                productRepository.save(product);
            }
        }

    }

    public List<Order> getAllOrdersByUser(HttpSession session) {
        String email = (String)session.getAttribute("email");
        User user = userRepository.findByEmail(email);

        List<Order> orders = new ArrayList<>();
        if(user != null){
            orders = orderRepository.findAllByUser(user);
        }
        return orders;
    }

    public List<OrderDetailDTO> getDetailsByOrder(Long orderId) {
        Order order = orderRepository.findById(orderId).get();
        // TODO Auto-generated method stub
        List<OrderDetail> orderDetails = orderDetailRepository.findByOrder(order);
        List<OrderDetailDTO> orderDetailDTOs = new ArrayList<>();

        for(OrderDetail orderDetail : orderDetails){
            OrderDetailDTO orderDetailDTO = new OrderDetailDTO();
            orderDetailDTO.setProductImg(orderDetail.getProduct().getProductImage());
            orderDetailDTO.setName(orderDetail.getProduct().getName());
            orderDetailDTO.setQuantity(orderDetail.getQuantity());
            orderDetailDTO.setPrice(orderDetail.getPrice());
            orderDetailDTOs.add(orderDetailDTO);
        }


        return orderDetailDTOs;
    }

}
