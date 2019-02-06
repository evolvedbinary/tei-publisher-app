import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
import './pb-mixin.js';
import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
import { mixinBehaviors } from './assets/@polymer/polymer/lib/legacy/class.js';
import { IronA11yKeysBehavior } from './assets/@polymer/iron-a11y-keys-behavior/iron-a11y-keys-behavior.js';
/**
 * Navigate backward/forward in a document. This component does not implement any functionality itself.
 * It just sends a `pb-navigate` event when clicked.
 *
 * @customElement
 * @polymer
 * @appliesMixin PbMixin
 * @demo demo/pb-view.html
 */
class PbNavigation extends mixinBehaviors([IronA11yKeysBehavior], PbMixin(PolymerElement)) {
  static get template() {
    return html`
        <a id="button" on-click="_handleClick"><slot></slot></a>
`;
  }

  static get is() {
      return 'pb-navigation';
  }

  static get properties() {
      return {
          /**
           * The direction to navigate in, either `forward` or `backward`
           */
          direction: {
              type: String,
              value: 'forward'
          },
          /**
           * Enable keyboard shortcuts: press left for backward, right for forward
           */
          keyboard: {
              type: String
          },
          keyEventTarget: {
              type: Object,
              value: function() {
                  return document.body;
              }
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();
  }

  ready(){
      super.ready();

      this.subscribeTo('pb-update', this._update.bind(this));

      if (this.keyboard) {
          this.addOwnKeyBinding(this.keyboard, '_handleClick');
      }
  }

  _handleClick() {
      this.emitTo('pb-navigate', { direction: this.direction });
  }

  _update(ev) {
      if (this.direction === 'forward') {
          this.$.button.disabled = !ev.detail.data.next;
      } else {
          this.$.button.disabled = !ev.detail.data.previous;
      }
  }
}

window.customElements.define(PbNavigation.is, PbNavigation);
