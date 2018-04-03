<tp-edit-xml title="{ title }" path="{ path }">
    <a ref="button" class="btn btn-default" title="{ title }">
        <yield/>
    </a>
    <script>
    this.mixin('navigation');

    var self = this;
    self.href = self.opts.eXide;
    self.dataRoot = self.opts.dataRoot;

    this.on('mount', function() {
        $(self.refs.button).click(function(ev) {
            ev.preventDefault();
            self.open(self.path);
        })
    });
    this.app.on('change', function(details) {
        self.path = self.dataRoot + '/' + details.path;
    });

    open(path) {
        // try to retrieve existing eXide window
        var exide = window.open("", "eXide");
        if (exide && !exide.closed) {
            // check if eXide is really available or it's an empty page
            var app = exide.eXide;
            if (app) {
                // eXide is there
                exide.eXide.app.findDocument(path);
                exide.focus();
                setTimeout(function() {
                    if ($.browser.msie ||
                        (typeof exide.eXide.app.hasFocus == "function" && !exide.eXide.app.hasFocus())) {
                        alert("Opened code in existing eXide window.");
                    }
                }, 200);
            } else {
                window.eXide_onload = function() {
                    exide.eXide.app.findDocument(path);
                };
                // empty page
                exide.location = self.href;
            }
        }
    }
    </script>
</tp-edit-xml>
