(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', 0);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });


    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });


    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })
    });



    // Product Quantity
    // Product Quantity + Update Cart
    $(document).ready(function () {
        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content") || "X-CSRF-TOKEN";

        $(".btn-plus, .btn-minus").click(function (e) {
            e.preventDefault();

            let parent = $(this).closest(".quantity");
            let input = parent.find("input"); // lấy input trong div.quantity
            let current = parseInt(input.val());
            let cartDetailId = parent.data("id");

            if ($(this).hasClass("btn-plus")) {
                current++;
            } else {
                current = current > 1 ? current - 1 : 1;
            }

            input.val(current);

            $.ajax({
                url: "/cart/update",
                type: "POST",
                data: {
                    cartDetailId: cartDetailId,
                    quantity: current
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(header, token);
                },
                success: function (res) {
                    console.log("Update thành công", res);
                    let formatted = res.total.toLocaleString("vi-VN"); // format theo locale VN
                    parent.closest("tr").find("td:nth-child(5) p").text(formatted + " đ");

                    // Cập nhật tổng tiền của cả giỏ hàng
                    let formattedTotal = res.totalPrice.toLocaleString("vi-VN");
                    $("#cartTotal").text(formattedTotal + " đ");
                },
                error: function (err) {
                    alert("Có lỗi xảy ra khi cập nhật giỏ hàng");
                }
            });
        });
    });


    function viewDetails(orderId) {
        $.ajax({
            url: '/orders/' + orderId + '/details',
            method: 'GET',
            success: function (data) {
                let tbody = $("#order-detail-body");
                tbody.empty();
                data.forEach(detail => {
                    tbody.append(`
                        <tr>
                          <td><img src="/images/product/${detail.productImg}" style="width:60px;height:60px;object-fit:cover;"/></td>
                          <td>${detail.name}</td>
                          <td>${detail.quantity}</td>
                          <td>${detail.price.toLocaleString("vi-VN")} đ</td>
                        </tr>
                    `);
                });
                $("#orderDetailModal").modal("show");
            },
            error: function () {
                alert("Không tải được chi tiết đơn hàng!");
            }
        });
    }

    // Gán sự kiện cho nút xem chi tiết
    $(document).on("click", ".btn-view-detail", function () {
        let orderId = $(this).data("id");
        viewDetails(orderId);
    });


})(jQuery);

