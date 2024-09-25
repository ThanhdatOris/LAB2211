(function () {
	"use strict";

	var treeviewMenu = $('.app-menu');

	// Toggle Sidebar
	$('[data-toggle="sidebar"]').click(function(event) {
		event.preventDefault();
		$('.app').toggleClass('sidenav-toggled');
	});

	// Activate sidebar treeview toggle
	$("[data-toggle='treeview']").click(function(event) {
		event.preventDefault();
		if(!$(this).parent().hasClass('is-expanded')) {
			treeviewMenu.find("[data-toggle='treeview']").parent().removeClass('is-expanded');
		}
		$(this).parent().toggleClass('is-expanded');
	});

	// Set initial active toggle
	$("[data-toggle='treeview.'].is-expanded").parent().toggleClass('is-expanded');

	//Activate bootstrip tooltips
	// $("[data-toggle='tooltip']").tooltip();

})();


// Lấy tất cả các thẻ 'a' với class 'app-menu__item'
const menuItems = document.querySelectorAll('.app-menu__item');

// Lấy URL hiện tại của trang
const currentPage = window.location.pathname.split('/').pop();

// Lặp qua từng menu item và kiểm tra nếu href khớp với URL hiện tại
menuItems.forEach(item => {
    const itemHref = item.getAttribute('href');

    // Nếu href của thẻ 'a' khớp với trang hiện tại, thêm class 'active'
    if (itemHref === currentPage || (currentPage === '' && itemHref === 'index.html')) {
        item.classList.add('active');
    } else {
        // Nếu không, đảm bảo xóa class 'active' khỏi các thẻ khác
        item.classList.remove('active');
    }
});

// Thêm sự kiện click cho từng thẻ 'a'
menuItems.forEach(item => {
    item.addEventListener('click', function() {
        // Xóa class 'active' khỏi tất cả các thẻ 'a'
        menuItems.forEach(i => i.classList.remove('active'));
        
        // Thêm class 'active' vào thẻ 'a' vừa được click
        this.classList.add('active');
    });
});
