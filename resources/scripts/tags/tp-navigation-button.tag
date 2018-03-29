<tp-navigation-button direction="{ direction }">
    <a class="{ direction=='previous' ? 'nav-prev' : 'nav-next' } page-nav btn btn-primary" onclick="{ navigate }" href="{ href }"
        ref="link">
        <i class="material-icons">{ (direction == 'previous') ? 'navigate_before' : 'navigate_next' }</i>
    </a>
    <script>
    this.mixin('navigation');

    var self = this;

    this.direction = this.opts.direction;

    navigate(ev) {
        this.app.trigger(this.direction, this.refs.link.search.substring(1));
    }

    this.app.on('change', function(details) {
        self.refs.link.href = self.direction == 'previous' ? details.previous : details.next;
    });
    </script>
</tp-navigation-button>
