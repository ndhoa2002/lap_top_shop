package vn.hoidanit.laptopshop.filter;

import java.math.BigDecimal;
import java.util.List;
import java.util.Locale.Category;

import org.springframework.data.jpa.domain.Specification;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;

public class ProductFilter {
    
    public static Specification<Product> nameLike(String name){
        return (root, query, cb) -> 
        (name == null || name.isEmpty())
            ? cb.conjunction()
            : cb.like(cb.lower(root.get(Product_.name)), "%" + name.toLowerCase() + "%");
    }


    public static Specification<Product> priceGreaterThanOrEqual(Double minPrice) {
        return (root, query, cb) ->
                (minPrice == null)
                        ? cb.conjunction()
                        : cb.greaterThanOrEqualTo(root.get(Product_.price), minPrice);
    }


    public static Specification<Product> priceLessThanOrEqual(Double maxPrice) {
        return (root, query, cb) ->
                (maxPrice == null)
                        ? cb.conjunction()
                        : cb.lessThanOrEqualTo(root.get(Product_.price), maxPrice);
    }


    public static Specification<Product> factoryIs(List<String> factories) {
        return (root, query, cb) ->
                (factories == null || factories.isEmpty())
                        ? cb.conjunction()
                        : root.get(Product_.factory).in(factories);
    }


    public static Specification<Product> targetIs(List<String> targets) {
        return (root, query, cb) ->
                (targets == null || targets.isEmpty())
                        ? cb.conjunction()
                        : root.get(Product_.target).in(targets);
    }
}
