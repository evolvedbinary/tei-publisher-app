/*
<link rel="import" href="bower_components/paper-button/paper-button.html">
<link rel="import" href="bower_components/iron-icon/iron-icon.html">
<link rel="import" href="bower_components/vaadin-upload/vaadin-upload.html">
*/
/*
  FIXME(polymer-modulizer): the above comments were extracted
  from HTML and may be out of place here. Review them and
  then delete this comment!
*/
import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';

import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
import './assets/@vaadin/vaadin-upload/vaadin-upload';
import './assets/@polymer/paper-button/paper-button';

/**
 * `pb-upload`
 *
 * a document upload component
 *
 * @customElement
 * @polymer
 */
class PbUpload extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
            }
        </style>

        <vaadin-upload id="uploader" accept=".xml,.tei,.odd" method="post" target="modules/lib/upload.xql" tabindex="-1" form-data-name="files[]">
            <span slot="drop-label">Drop files here.</span>
            <paper-button id="uploadBtn" slot="add-button">upload</paper-button>
        </vaadin-upload>
`;
  }

  static get is() {
      return 'pb-upload';
  }

  static get properties() {
      return {
          /**
           * the server-side script to handle the upload
           */
          target: {
              type: String
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();

      this.$.uploader.addEventListener('upload-before', function (event) {
          this.emitTo('pb-start-update');
      }.bind(this));
      this.$.uploader.addEventListener('upload-request', function(event) {
          if (this.target) {
              event.detail.formData.append('root', this.target);
          }
      }.bind(this));
      this.$.uploader.addEventListener('upload-error', function(event) {
          event.detail.file.error = event.detail.xhr.responseText;
          this.emitTo('pb-end-update');
      });
      this.$.uploader.addEventListener('upload-success', function (event) {
          let done = true;
          this.$.uploader.files.forEach(function(file) {
              if (!(file.complete || file.error || file.aborted)) {
                  done = false;
              }
          });
          if (done) {
              this.emitTo('pb-end-update');
              this.emitTo('pb-load');
              fetch("modules/index.xql").then(function() {
                  console.log("Reindex done.");
              }.bind(this));
          }
      }.bind(this));
  }

  ready(){
      super.ready();
  }
}

window.customElements.define(PbUpload.is, PbUpload);
