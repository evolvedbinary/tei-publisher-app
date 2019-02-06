/*
    todo: just ported 'statically' - needs functional integration and testing
*/
/*
  FIXME(polymer-modulizer): the above comments were extracted
  from HTML and may be out of place here. Review them and
  then delete this comment!
*/
import { PolymerElement } from '../assets/@polymer/polymer/polymer-element.js';

import { html } from '../assets/@polymer/polymer/lib/utils/html-tag.js';
import '../assets/@cwmr/paper-autocomplete/paper-autocomplete';
import './odd-code-editor';
import '../assets/@polymer/paper-icon-button/paper-icon-button';

/**
 * `odd-parameter`
 *
 *
 * @customElement
 * @polymer
 */
class OddParameter extends PolymerElement {
  static get template() {
    return html`
        <style include="code-mirror-styles">
            :host {
                display: block;
            }

            .wrapper{
                display:flex;
                flex-direction: row;
                margin-bottom:10px;
            }
            paper-autocomplete {
                flex: 0 1;
                min-width: 128px;
            }
            odd-code-editor {
                flex: 1 0;
                margin-left: 10px;
            }
            .actions{
                flex: 0 0;
                align-self: end;
                text-align: right;
            }

        </style>

        <div class="wrapper">
            <paper-autocomplete id="combo" text="{{name}}" placeholder="[Param name]" label="Name" source="[]"></paper-autocomplete>
            <!--<paper-input id="textarea" on-change="_handleChange" value="{{value}}" label="value"></paper-input>-->

            <odd-code-editor id="editor" mode="xquery" code="{{value}}" on-change="_handleChange"></odd-code-editor>
            <div class="actions">
                <paper-icon-button on-click="delete" icon="delete"></paper-icon-button>
            </div>
        </div>
`;
  }

  static get is() {
      return 'odd-parameter';
  }

  static get properties() {
      return {
          name: {
              type: String,
              notify: true,
              reflectToAttribute: true
          },
          value: {
              type: String,
              value: '',
              notify: true,
              reflectToAttribute: true
          }
      };
  }

  constructor() {
      super();

      const parameters = {
          alternate: ["content", "default", "alternate"],
          anchor: ["content", "id"],
          block: ["content"],
          body: ["content"],
          break: ["content", "type"],
          cell: ["content"],
          cit: ["content", "source"],
          "document": ["content"],
          figure: ["content", "title"],
          graphic: ["content", "url", "width", "height", "scale", "title"],
          heading: ["content", "level"],
          inline: ["content"],
          link: ["content", "link"],
          list: ["content"],
          listItem: ["content"],
          metadata: ["content"],
          note: ["content", "place", "label"],
          omit: ["content"],
          paragraph: ["content"],
          row: ["content"],
          section: ["content"],
          table: ["content"],
          text: ["content"],
          title: ["content"]
      };

  }

  connectedCallback() {
      super.connectedCallback();
      this.value = this.value.trim();
      this.dispatchEvent(new CustomEvent('parameter-connected', {composed:true, bubbles:true, detail: {target: this}}));
  }

  updateList() {
      var autocomplete = [];
      var values = parameters[this.parent.getBehaviour()] || [];

      values.forEach(function (val) {
          autocomplete.push({
              text: val, value: val
          });
      });
      this.$.combo.source = autocomplete;
  }

  delete(ev) {
      console.log('parameter delete ', ev);
      ev.preventDefault();
      this.dispatchEvent(new CustomEvent('parameter-remove', {}));
  }

  getData() {
      return {
          name: this.$.combo.text,
          value: this.$.editor.getSource()
      };
  }

  refreshEditor(){
      this.$.editor.refresh();
  }

  _handleChange() {
      this.value = this.$.editor.getSource();
  }
}

window.customElements.define(OddParameter.is, OddParameter);
