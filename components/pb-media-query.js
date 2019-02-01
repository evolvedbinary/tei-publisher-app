import { PolymerElement } from '../@polymer/polymer/polymer-element.js';
import { html } from '../@polymer/polymer/lib/utils/html-tag.js';
/**
 * Show or hide contents depending on a media query. This is used to toggle the menubar and drawer.
 * On small displays, the menu will move into the drawer.
 *
 * @customElement
 * @polymer
 */
class PbMediaQuery extends PolymerElement {
  static get template() {
    return html`
        <style>
            :host {
                display: none;
            }

            :host(.active) {
                display: inherit;
            }
        </style>

        <template is="dom-if" if="{{queryMatches}}">
            <slot></slot>
        </template>

        <iron-media-query query="{{query}}" query-matches="{{queryMatches}}">
    </iron-media-query>
`;
  }

  static get is() {
      return 'pb-media-query';
  }

  static get properties() {
      return {
          query: {
              type: String
          },
          queryMatches: {
              type: Boolean,
              reflectToAttribute: true,
              observer: '_show'
          }
      };
  }

  _show() {
      if (this.queryMatches) {
          this.className = 'active';
      } else {
          this.className = '';
      }
  }

  connectedCallback() {
      super.connectedCallback();
  }
}

window.customElements.define(PbMediaQuery.is, PbMediaQuery);
