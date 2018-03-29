<tp-download-button title="{ title }" type="{ type }" source="{ source }" target="{ target }">
    <a ref="link" class="btn btn-default download-link" title="{ title }" href="" target="{ target }">
        <yield/>
    </a>
    <script>
    this.mixin('navigation');

    var self = this;

    this.title = this.opts.title;
    this.type = this.opts.type;
    this.source = this.opts.source || '';
    this.mode = this.opts.mode || '';
    this.target = this.opts.target;

    this.app.on('change', function(details) {
        self.token = Date.now();
        self.refs.link.href = details.path + '.' + self.type + '?cache=no&odd=' + details.odd + '&source=' + self.source +
            '&mode=' + self.mode + '&token=' + self.token;
    });

    this.on('mount', function() {
        $(self.refs.link).click(function(ev) {
            if (self.target !== 'new') {
                $("#pdf-info").modal("show");
                var downloadCheck = window.setInterval(function() {
                    var cookieValue = $.macaroon("simple.token");
                    if (cookieValue == self.token) {
                        window.clearInterval(downloadCheck);
                        $.macaroon("simple.token", null);
                        $("#pdf-info").modal("hide");
                    }
                });
            }
        });
    });
    </script>
</tp-download-button>
