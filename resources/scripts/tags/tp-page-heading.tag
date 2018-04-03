<tp-page-heading>
    <script>
    this.mixin('navigation');
    
    var self = this;
    this.app.on('change', function(details) {
        self.root.innerHTML = details.title;
    });
</tp-page-heading>