/*
<link rel="import" href="bower_components/paper-progress/paper-progress.html">
*/
/*
  FIXME(polymer-modulizer): the above comments were extracted
  from HTML and may be out of place here. Review them and
  then delete this comment!
*/
import { PolymerElement } from '../@polymer/polymer/polymer-element.js';

import { html } from '../@polymer/polymer/lib/utils/html-tag.js';
/**
 * `pb-progress`
 *
 * a progress bar
 *
 * @customElement
 * @polymer
 */
class PbProgress extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
                display: block;
                visibility: hidden;
            }

            paper-progress {
                width: 100%;
            }
        </style>

        <paper-progress id="progress" indeterminate=""></paper-progress>
`;
  }

  static get is() {
      return 'pb-progress';
  }

  connectedCallback() {
      super.connectedCallback();
      this.$.progress.disabled = true;
  }

  ready() {
      super.ready();
      this.subscribeTo('pb-start-update', this._startUpdate.bind(this));
      this.subscribeTo('pb-end-update', this._endUpdate.bind(this));
  }

  _startUpdate() {
      console.log('<pb-progress> start update');
      this.style.visibility = 'visible';
      this.$.progress.disabled = false;
  }

  _endUpdate() {
      this.style.visibility = 'hidden';
      this.$.progress.disabled = true;
  }
}

window.customElements.define(PbProgress.is, PbProgress);
