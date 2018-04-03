<tp-document doc="{ doc }" root="{ root }" odd="{ odd }" view="{ view }">
    <div class="content" ref="content"></div>
    <style>
    .content {
        -webkit-animation-duration: 400ms;
        -moz-animation-duration: 400ms;
        animation-duration: 400ms;
        overflow-wrap: break-word;
    }
    </style>
    <script>
    this.mixin('navigation');

    var self = this;

    self.doc = self.opts.doc;
    self.root = self.opts.root;
    self.odd = self.opts.odd;
    self.view = self.opts.view;
    
    load(params, direction) {
        console.log("Loading %o", params);

        var animOut = direction == "nav-next" ? "fadeOutLeft" : (direction == "nav-prev" ? "fadeOutRight" : "fadeOut");
        var animIn = direction == "nav-next" ? "fadeInRight" : (direction == "nav-prev" ? "fadeInLeft" : "fadeIn");
        var container = $(this.refs.content);
        container.addClass("animated " + animOut)
            .one("webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend", function() {
            $.ajax({
                url: "http://localhost:8080/exist/apps/tei-publisher/modules/lib/ajax.xql",
                data: params,
                dataType: "json",
                success: function(data) {
                    $(self.refs.content).html(data.content);
                    self.app.trigger("change", data);
                    self.initContent();
                    container.removeClass("animated " + animOut);
                    container.addClass("animated " + animIn).one("webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend", function() {
                        $(this).removeClass("animated " + animIn);
                    });
                }
            });
        });
    }

    initContent() {
        var content = $(this.refs.content);
        content.find(".note").popover({
            html: true,
            trigger: "hover",
            placement: "auto bottom",
            viewport: "#document-pane",
            content: function() {
                var fn = document.getElementById(this.hash.substring(1));
                return $(fn).find(".fn-content").html();
            }
        });
        content.find(".fn-back").click(function(ev) {
            ev.preventDefault();
            var fn = document.getElementById(this.hash.substring(1));
            fn.scrollIntoView();
        });
        content.find('pre.code').each(function(i, block) {
          hljs.highlightBlock(block);
        });
        content.find(".alternate").each(function() {
            $(this).popover({
                content: $(this).find(".altcontent").html(),
                trigger: "hover",
                html: true,
                container: "#document-wrapper"
            });
        });
    }

    getFontSize() {
        var size = $(self.refs.content).css("font-size");
        return parseInt(size.replace(/^(\d+)px/, "$1"));
    }

    this.on("mount", function() {
        self.load(self.opts);
    });
    this.app.on("previous", function(search) {
        self.load("doc=" + self.opts.doc + "&" + search, 'nav-prev');
    });
    this.app.on("next", function(search) {
        self.load("doc=" + self.opts.doc + "&" + search, 'nav-next');
    });
    this.app.on("zoom-in", function() {
        var size = self.getFontSize();
        $(self.refs.content).css("font-size", (size + 1) + "px");
    });
    this.app.on("zoom-out", function() {
        var size = self.getFontSize();
        $(self.refs.content).css("font-size", (size - 1) + "px");
    });
    </script>
</tp-document>
