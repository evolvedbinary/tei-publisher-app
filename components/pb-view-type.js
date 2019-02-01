import { PolymerElement } from '../@polymer/polymer/polymer-element.js';
import './pb-mixin.js';
import { html } from '../@polymer/polymer/lib/utils/html-tag.js';
/**
 * A checkbox to switch between page-by-page and division-by-division view.
 * Needs to be subscribed to a particular view. Listen to its `update` event
 * to determine current view type and reading position.
 *
 * @customElement
 * @polymer
 * @appliesMixin PbMixin
 */
class PbViewType extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <paper-checkbox id="button" checked="{{isActive}}" on-click="_toggle"><slot></slot></paper-checkbox>
`;
  }

  static get is() {
      return 'pb-view-type';
  }

  static get properties() {
      return {
          isActive: {
              type: Boolean,
              value: false
          },
          type: {
              type: String,
              value: 'div',
              computed: '_setType(isActive)'
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();
  }

  ready(){
      super.ready();

      this.subscribeTo('pb-update', this._update.bind(this));
  }

  _setType(isActive) {
      return isActive ? 'page' : 'div';
  }

  _update(ev) {
      this.isActive = ev.detail.data.view === 'page';
      this.root = ev.detail.data.switchView;
  }

  _toggle(ev) {
      console.log("<pb-view-type> toggle: %s", this.type);
      this.emitTo('pb-refresh', {
          'view': this.type,
          'position': this.root
      });
  }
  /**
   * Fired when the user toggles the element.
   *
   * @event pb-refresh
   * @param {object} view the view type to switch to: either `page` or `div`
   * @param {String} position the position in the document to be shown
   */
}

window.customElements.define(PbViewType.is, PbViewType);
