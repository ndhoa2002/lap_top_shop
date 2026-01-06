package vn.myproject.laptopshop.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.myproject.laptopshop.domain.Product;
import vn.myproject.laptopshop.domain.User;
import vn.myproject.laptopshop.filter.ProductFilter;
import vn.myproject.laptopshop.service.ProductService;
import vn.myproject.laptopshop.service.UploadService;

@Controller
public class ProductController {

    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getAllProduct(Model model, @RequestParam(defaultValue = "0") int page,
    @RequestParam(defaultValue = "5") int size,
    @RequestParam(required = false) String name,
    @RequestParam(required = false) Double minPrice,
    @RequestParam(required = false) Double maxPrice,
    @RequestParam(required = false) List<String> factory,
    @RequestParam(required = false) List<String> target) {

        Specification<Product> spec = Specification
            .where(ProductFilter.nameLike(name))
            .and(ProductFilter.priceGreaterThanOrEqual(minPrice))
            .and(ProductFilter.priceLessThanOrEqual(maxPrice))
            .and(ProductFilter.factoryIs(factory))
            .and(ProductFilter.targetIs(target));

        Page<Product> products = productService.getAllProducts(page, size, spec);
        model.addAttribute("products", products);
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProductPage(Model model,
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProducBindingResult,
            @RequestParam("ndhoaFile") MultipartFile file) {

        // validate
        List<FieldError> errors = newProducBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if (newProducBindingResult.hasErrors()) {
            return "admin/product/create";
        }

        String avatar = this.uploadService.handleSaveUploadFile(file, "product");

        product.setProductImage(avatar);
        this.productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }

    @RequestMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Product currentProduct = this.productService.getProductById(id);
        model.addAttribute("newProduct", currentProduct);
        model.addAttribute("id", id);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String updateProduct(Model model,
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProducBindingResult,
            @RequestParam("ndhoaFile") MultipartFile file) {

        System.out.println("product id is" + product.getId());

        Product currentProduct = productService.getProductById(product.getId());

        // validate
        List<FieldError> errors = newProducBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        // validate
        if (newProducBindingResult.hasErrors()) {
            return "admin/product/update";
        }

        
        if (currentProduct != null) {
            if(!file.isEmpty()){
                String avatar = this.uploadService.handleSaveUploadFile(file, "product");
                currentProduct.setProductImage(avatar);
            }
            currentProduct.setName(product.getName());
            currentProduct.setDetailDesc(product.getDetailDesc());
            currentProduct.setShortDesc(product.getShortDesc());
            currentProduct.setFactory(product.getFactory());
            
            currentProduct.setPrice(product.getPrice());
            currentProduct.setQuantity(product.getQuantity());
            currentProduct.setSold(product.getSold());
            currentProduct.setTarget(product.getTarget());
            this.productService.handleSaveProduct(currentProduct);
        }

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newProduct") Product product) {
        this.productService.deleteProduct(product.getId());
        return "redirect:/admin/product";
    }
}
