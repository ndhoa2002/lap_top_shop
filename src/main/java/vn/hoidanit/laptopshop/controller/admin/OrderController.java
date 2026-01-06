package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import vn.hoidanit.laptopshop.common.OrderStatus;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.service.OrderService;

@Controller
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrders(Model model, @RequestParam(defaultValue = "0") int page,
    @RequestParam(defaultValue = "5") int size) {
        Page<Order> orders = orderService.getAllOrders(page, size);
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @PostMapping("/admin/order/updateStatus")
    @ResponseBody
    public ResponseEntity<?> updateOrderStatus(@RequestParam Long id,
            @RequestParam OrderStatus status) {
        try {
            orderService.updateStatus(id, status);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Update failed");
        }
    }

}
