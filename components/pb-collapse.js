import { PolymerElement } from '../@polymer/polymer/polymer-element.js';
import '../@polymer/iron-collapse/iron-collapse.js';
import '../@polymer/iron-icon/iron-icon.js';
import './pb-mixin.js';
import { html } from '../@polymer/polymer/lib/utils/html-tag.js';
/**
 * An iron-collapse with additional trigger section and optional expand/collapse icons.
 * Mainly used for the table of contents.
 *
 * @customElement
 * @polymer
 * @appliesMixin PbMixin
 */
class PbCollapse extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
                display: block;
            }

            #trigger {
                display: flex;
                flex-direction: row;
                justify-content: flex-start;
                align-items: center;

                @apply --pb-collapse-trigger;
            }

            #trigger iron-icon {
                display: block;
                margin-right: 4px;
            }
        </style>

        <div id="trigger" on-click="toggle" class="collapse-trigger">
            <iron-icon icon="[[_toggle(opened, collapseIcon, expandIcon)]]"></iron-icon>
            <slot id="collapseTrigger" name="collapse-trigger"></slot>
        </div>
        <iron-collapse id="collapse" horizontal="[[horizontal]]" no-animation="[[noAnimation]]" opened="[[opened]]">
            <slot name="collapse-content"></slot>
        </iron-collapse>
`;
  }

  static get is() {
      return 'pb-collapse';
  }

  static get properties() {
      return {
          /**
           * @deprecated
           * Corresponds to the iron-collapse's horizontal property.
           */
          horizontal: {
              type: Boolean,
              value: false
          },
          /**
           * Corresponds to the iron-collapse's noAnimation property.
           *
           */
          noAnimation: {
              type: Boolean,
              value: false
          },
          /**
           * Whether currently expanded.
           *
           */
          opened: {
              type: Boolean,
              value: false,
              notify: true
          },
          /**
           * The iron-icon when collapsed. Value must be one of the icons defined by iron-icons
           */
          expandIcon: {
              type: String,
              value: 'icons:expand-more'
          },
          /**
           * The icon when expanded.
           */
          collapseIcon: {
              type: String,
              value: 'icons:expand-less'
          },
          /**
           * Whether to hide the expand/collapse icon.
           */
          noIcons: {
              type: Boolean,
              value: false
          },
          data: {
              type: Object
          }
      }
  }

  /**
   * opens the collapsible section
   */
  open() {
      this.opened = true;
      this.emitTo('pb-collapse-open', this.data);
  }

  /**
   * closes the collapsible section
   */
  close() {
      this.opened = false;
  }

  /**
   * toggles the collapsible state
   */
  toggle() {
      this.opened = !this.opened;
      if (this.opened) {
          this.emitTo('pb-collapse-open', this.data);
      }
  }

  _toggle(cond, t, f) {
      return cond ? t : f;
  }

  _getLabel() {
      const nodes = this.$.collapseTrigger.assignedNodes();
      if (nodes && nodes.length > 0) {
          return nodes[0].innerHTML;
      }
  }
}

window.customElements.define(PbCollapse.is, PbCollapse);
