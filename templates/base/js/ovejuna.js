!function ($) {
	$(document).on("ready", function() {
		var projectAddLayer = $("#project-add-layer");
		projectAddLayer.find("a[data-action=submit]").on("click", function() {
			projectAddLayer.find("form").submit();
			return false;
		});
	});
}(window.jQuery);