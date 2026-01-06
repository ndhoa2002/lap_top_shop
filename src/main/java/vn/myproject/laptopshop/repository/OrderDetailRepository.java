package vn.myproject.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.myproject.laptopshop.domain.Order;
import vn.myproject.laptopshop.domain.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long>{
    
    List<OrderDetail> findByOrder(Order order);
}
