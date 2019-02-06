import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
/**
 * `pb-grid-action`
 *
 * an action component to execute an 'add panel' or 'remove panel' action on a pb-grid.
 *
 * @customElement
 * @polymer
 * @demo demo/pb-grid.html
 */
class PbGridAction extends PolymerElement {
  static get template() {
    return html`
        <style>
            :host {
                display: block;
            }
        </style>

        <a on-click="_click"><slot></slot></a>
`;
  }

  static get is() {
      return 'pb-grid-action';
  }

  static get properties() {
      return {
          /**
           * the type of action. Can be either `add` or `remove`
           *
           * Defaults to `add`
           */
          action: {
              type: String,
              value: 'add'
          },
          /**
           * reference to a pb-grid element
           */
          grid: {
              type: String
          },
          initial: {
              type: Number
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();
  }

  ready(){
      super.ready();
  }

  _click() {
      // todo: grid must be in lightDOM to be discovered. What is expected for this.grid? A string like '#myId'?
      const grid = document.querySelector(this.grid);
      if (!(grid && grid.addPanel)) {
          return console.error('<pb-grid-action> grid not found: %s', this.grid);
      }
      if (this.action === 'add') {
          grid.addPanel(this.initial);
      } else {
          grid.removePanel(this.parentNode);
      }
  }
}

window.customElements.define(PbGridAction.is, PbGridAction);
