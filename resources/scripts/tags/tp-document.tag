<tp-document doc="{ doc }" root="{ root }" odd="{ odd }" view="{ view }">
    <div class="content" ref="content"></div>
    <script>
    this.mixin('navigation');

    var self = this;

    load(params) {
        console.log("Loading %o", params);
        $.ajax({
            url: "http://localhost:8080/exist/apps/tei-publisher/modules/lib/ajax.xql",
            data: params,
            dataType: "json",
            success: function(data) {
                $(self.refs.content).html(data.content);
                self.app.trigger("change", data);
            }
        });
    }

    this.on("mount", function() {
        self.load(self.opts);
    });
    this.app.on("previous", function(search) {
        self.load("doc=" + self.opts.doc + "&" + search);
    });
    this.app.on("next", function(search) {
        self.load("doc=" + self.opts.doc + "&" + search);
    });
    </script>
</tp-document>
