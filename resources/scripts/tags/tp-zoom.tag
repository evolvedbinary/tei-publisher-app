<tp-zoom mode="{ mode }">
    <a ref="button" class="btn btn-default">
        <i class="material-icons">zoom_{ mode }</i>
    </a>
    <script>
    this.mixin('navigation');

    var self = this;
    this.mode = this.opts.mode;

    this.on('mount', function() {
        $(self.refs.button).click(function(ev) {
            ev.preventDefault();
            self.app.trigger('zoom-' + self.mode);
        });
    });
    </script>
</tp-zoom>
