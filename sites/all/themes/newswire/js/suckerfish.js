// $Id: suckerfish.js,v 1.2 2009/11/03 22:22:04 jmburnz Exp $
sfHover = function() {
	var sfEls = document.getElementById("suckerfish").getElementsByTagName("LI");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=" sfhover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
		}
	}
}
if (window.attachEvent) window.attachEvent("onload", sfHover);
