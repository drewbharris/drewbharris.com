var App = {};

App.sections = ['artist', 'developer', 'photographer', 'about'];

App.activeSection = null;

App.setActive = function(section){
	if (!this.activeSection) {
		$("#menu-" + section).addClass('active');
		$("#content-" + section).fadeIn(200);
		this.activeSection = section;
		return;
	}
	if (this.activeSection !== section) {
		$("#menu-" + this.activeSection).removeClass('active');
		$("#content-" + this.activeSection).fadeOut(200, function(){
			$("#menu-" + section).addClass('active');
			$("#content-" + section).fadeIn(200);
			this.activeSection = section;
			return;
		}.bind(this));
		
	}
};

App.menuInit = function(){
	this.sections.map(function(section){
		$("#menu-" + section).click(function(e){
			this.setActive(section);
		}.bind(this));
	}.bind(this));
};




$(document).ready(function(){
	App.menuInit();
});