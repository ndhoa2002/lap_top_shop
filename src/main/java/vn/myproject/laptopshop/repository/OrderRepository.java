package vn.myproject.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.myproject.laptopshop.domain.Order;
import vn.myproject.laptopshop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>{
    
    List<Order> findAllByUser(User user);

    Page<Order> findAll(Pageable pageable);
}
