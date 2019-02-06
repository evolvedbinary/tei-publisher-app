import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
import './pb-mixin.js';
import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
/**
 * Represents a Publisher document. It has no visual presentation but holds meta-data
 * about the document to be used by other components like `pb-view`. Every `pb-view`
 * references a `pb-document`.
 * `pb-document` requires an id attribute to allow other components to access it.
 *
 * @customElement
 * @polymer
 * @demo demo/pb-document.html
 * @appliesMixin PbMixin
 */
class PbDocument extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
                display: none;
            }
        </style>
`;
  }

  static get is() {
      return 'pb-document';
  }

  static get properties() {
      return {
          /**
           * The path to the document to be loaded. Should be relative to `root`.
           */
          path: {
              type: String,
              value: '',
              reflectToAttribute: true
          },
          /**
           * The root collection which will be used to resolve relative paths
           * specified in `path`.
           */
          rootPath: {
              type: String,
              value: ''
          },
          /**
           * The odd file which should be used to render this document by default. Might be
           * overwritten in a `pb-view`. The odd should be specified by its name without path
           * or the `.odd` suffix.
           */
          odd: {
              type: String,
              reflectToAttribute: true
          },
          /**
           * The default view to be used for displaying this document. Can be either `page`, `div` or `simple`.
           * Might be overwritten in a `pb-view`.
           *
           * Value | Displayed content
           * ------|------------------
           * `page` | content is displayed page by page as determined by tei:pb
           * `div` | content is displayed by divisions
           * `single` | do not paginate but display entire content at once
           */
          view: {
              type: String,
              reflectToAttribute: true
          },
          sourceView: {
              type: String
          }
      };
  }

  static get observers() {
      return [
          '_update(path, odd, view)'
      ]
  }

  connectedCallback() {
      super.connectedCallback();
  }

  ready() {
      super.ready();
  }

  _update() {
      console.log('<pb-document> Emit update event');
      this.emitTo('pb-document', this);
  }

  /**
   * Returns the name of the document without path.
   *
   * @returns {string} Name of the document
   */
  getFileName() {
      return this.path.replace(/^.*?([^\/]+)$/, '$1');
  }

  /**
   * Returns the full path to the document.

   * @returns {string} Full path to the document
   */
  getFullPath() {
      return this.rootPath + '/' + this.path;
  }
}

window.customElements.define(PbDocument.is, PbDocument);
