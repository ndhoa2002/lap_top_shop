package vn.myproject.laptopshop.common;

public enum OrderStatus {
    PENDING("Chờ xác nhận"),
    SHIPPING("Đang vận chuyển"),
    COMPLETED("Đã giao hàng"),
    CANCEL("Đã hủy đơn hàng");

    private final String label;

    OrderStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
