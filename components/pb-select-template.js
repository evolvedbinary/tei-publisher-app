import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
import './assets/@polymer/paper-dropdown-menu/paper-dropdown-menu.js';
import './assets/@polymer/paper-listbox/paper-listbox.js';
import './assets/@polymer/paper-item/paper-item.js';
import './assets/@polymer/iron-ajax/iron-ajax.js';

/**
 * `pb-select-template`: Switch between available ODDs.
 * It loads the list of ODDs from `components-odd.xql`.
 * Emits a `pb-refresh` event to subscribed views.
 *
 *
 * @customElement
 * @polymer
 */
class PbSelectTemplate extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
                display: block;
            }

            paper-dropdown-menu {
                --paper-listbox-background-color: white;
                width: 100%;
            }
        </style>

        <paper-dropdown-menu id="menu" label="[[label]]" name="[[name]]">
            <paper-listbox slot="dropdown-content" class="dropdown-content" selected="{{template}}" attr-for-selected="value">
                <template is="dom-repeat" items="[[_templates]]">
                    <paper-item value\$="[[item.name]]">[[item.title]]</paper-item>
                </template>
            </paper-listbox>
        </paper-dropdown-menu>

        <iron-ajax id="getTemplates" url="modules/lib/components-list-templates.xql" handle-as="json" on-response="_handleTemplatesResponse" method="GET" auto=""></iron-ajax>
`;
  }

  static get is() {
      return 'pb-select-template';
  }

  static get properties() {
      return {
          /** The label to show on top of the dropdown menu */
          label: {
              type: String,
              value: 'Template'
          },
          /** Currently selected ODD. If this property is set, the component
           * will immediately load the list of ODDs from the server and select
           * the given ODD.
           */
          template: {
              type: String,
              observer: '_selected'
          },
          _templates: {
              type: Array
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();

      const page = document.querySelector('pb-page');
      if (page) {
          this.template = page.template;
      }
  }

  ready() {
      super.ready();
  }

  _selected(newTemplate, oldTemplate) {
      if (typeof oldTemplate !== 'undefined' && newTemplate && newTemplate !== oldTemplate) {
          this.setParameter('template', newTemplate);
          window.location = this.getUrl().toString();
      }
  }

  _handleTemplatesResponse() {
      this._templates = this.$.getTemplates.lastResponse;
  }
}

window.customElements.define(PbSelectTemplate.is, PbSelectTemplate);
