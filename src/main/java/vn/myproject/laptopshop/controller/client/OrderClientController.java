package vn.myproject.laptopshop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.myproject.laptopshop.domain.Cart;
import vn.myproject.laptopshop.domain.CartDetail;
import vn.myproject.laptopshop.domain.Order;
import vn.myproject.laptopshop.domain.OrderDetail;
import vn.myproject.laptopshop.domain.User;
import vn.myproject.laptopshop.domain.dto.OrderDTO;
import vn.myproject.laptopshop.domain.dto.OrderDetailDTO;
import vn.myproject.laptopshop.repository.CartRepository;
import vn.myproject.laptopshop.repository.UserRepository;
import vn.myproject.laptopshop.service.OrderService;

@Controller
public class OrderClientController {

    private final OrderService orderService;
    private final UserRepository userRepository;
    private final CartRepository cartRepository;

    public OrderClientController(OrderService orderService, UserRepository userRepository,
            CartRepository cartRepository) {
        this.orderService = orderService;
        this.userRepository = userRepository;
        this.cartRepository = cartRepository;
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        List<CartDetail> cartDetails = orderService.getCartDetails(email);
        User user = userRepository.findByEmail(email);
        Cart cart = cartRepository.findByUser(user);
        model.addAttribute("totalPrice", cart.getTotalPrice());
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("checkout", new OrderDTO());
        return "client/order/checkout";
    }

    @PostMapping("/checkout/success")
    public String handleCheckout(@ModelAttribute("checkout") @Valid OrderDTO orderDTO, BindingResult bindingResult,
            HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");

        if (bindingResult.hasErrors()) {
            List<CartDetail> cartDetails = orderService.getCartDetails(email);
            User user = userRepository.findByEmail(email);
            Cart cart = cartRepository.findByUser(user);
            model.addAttribute("totalPrice", cart.getTotalPrice());
            model.addAttribute("cartDetails", cartDetails);
            return "client/order/checkout";
        }

        orderService.hanleSaveOrder(email, orderDTO, session);

        return "client/order/orderSuccess";
    }

    @GetMapping("/orders")
    public String getAllOrder(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        List<Order> orders = orderService.getAllOrdersByUser(session);
        model.addAttribute("orders", orders);
        return "client/order/orderChecking";
    }

    @GetMapping("/orders/{orderId}/details")
    @ResponseBody
    public List<OrderDetailDTO> getOrderDetails(@PathVariable Long orderId) {
        return orderService.getDetailsByOrder(orderId);
    }
}
