/*!
    * Start Bootstrap - SB Admin v7.0.7 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2023 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */
// 
// Scripts
// 

window.addEventListener('DOMContentLoaded', event => {

    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle between refreshes
        // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
        //     document.body.classList.toggle('sb-sidenav-toggled');
        // }
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }

});


let currentOrderId = null;
let currentOrderStatus = null;

function openConfirmModal(orderId, status) {
    currentOrderId = orderId;
    currentOrderStatus = status;

    // đổi tiêu đề modal tùy trạng thái
    let title = document.querySelector("#confirmModal .modal-title");
    if (status === 'SHIPPING') {
        title.textContent = "Xác nhận cập nhật trạng thái đơn hàng";
    } else {
        title.textContent = "Xác nhận duyệt đơn hàng";
    }

    let description = document.querySelector("#confirmModal .modal-body");
    if(status === 'SHIPPING'){
        description.textContent = "Bạn có muốn cập nhật trạng thái đơn hàng này";
    }else{
        description.textContent = "Bạn có muốn duyệt đơn hàng này";
    }

    let modal = new bootstrap.Modal(document.getElementById('confirmModal'));
    modal.show();
}

document.getElementById('btnApproveOrder').addEventListener('click', function () {
    // nếu hiện tại mới đặt thì chuyển sang SHIPPING
    // nếu đã SHIPPING thì chuyển sang COMPLETED
    let nextStatus = currentOrderStatus === 'SHIPPING' ? 'COMPLETED' : 'SHIPPING';
    updateOrderStatus(currentOrderId, nextStatus);
});

document.getElementById('btnCancelOrder').addEventListener('click', function () {
    updateOrderStatus(currentOrderId, 'CANCEL');
});

function updateOrderStatus(orderId, status) {
    const token = document.querySelector("meta[name='_csrf']").getAttribute("content");
    const header = document.querySelector("meta[name='_csrf_header']").getAttribute("content");

    fetch(`/admin/order/updateStatus?id=${orderId}&status=${status}`, {
        method: 'POST',
        headers: {
            [header]: token
        }
    }).then(res => {
        if (res.ok) {
            location.reload(); // reload lại trang để thấy thay đổi
        } else {
            alert("Lỗi khi cập nhật trạng thái!");
        }
    }).catch(
        err => {
            alert("Có lỗi kết nối đến server!");
            console.error(err);
        }
    )
}

