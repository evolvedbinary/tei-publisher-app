import { PolymerElement } from './assets/@polymer/polymer/polymer-element.js';
import { html } from './assets/@polymer/polymer/lib/utils/html-tag.js';
import './assets/google-maps/lib/Google';
import './assets/@polymer/polymer/lib/elements/dom-repeat';
/**
 * `pb-map`
 *
 * a wrapper for a google map
 *
 *
 * @customElement
 * @polymer
 */
class PbMap extends PbMixin(PolymerElement) {
  static get template() {
    return html`
        <style>
            :host {
                display: block;
            }

            google-map {
                width: 100%;
                height: 100%;
            }
        </style>

        <google-map id="map" api-key="[[apiKey]]" latitude="[[latitude]]" longitude="[[longitude]]" zoom="[[zoom]]">
            <template is="dom-repeat" items="[[markers]]">
                <!--todo: what is the right dependency to import for this? -->
                <google-map-marker slot="markers" latitude="[[item.latitude]]" longitude="[[item.longitude]]" label="[[item.label]]"></google-map-marker>
            </template>
        </google-map>
`;
  }

  static get is() {
      return 'pb-map';
  }

  static get properties() {
      return {
          /**
           * the Google apikey to access Google maps service
           */
          apiKey: {
              type: String
          },
          label: {
              type: String
          },
          latitude: {
              type: Number
          },
          longitude: {
              type: Number
          },
          zoom: {
              type: Number,
              value: 14
          },
          markers: {
              type: Array,
              value: []
          }
      };
  }

  connectedCallback() {
      super.connectedCallback();

      this.subscribeTo('pb-update', function(ev) {
          const markers = [];
          ev.detail.root.querySelectorAll('pb-geolocation').forEach(function(loc) {
              const marker = {
                  latitude: loc.latitude,
                  longitude: loc.longitude,
                  label: loc.label
              };
              markers.push(marker);
          }.bind(this));
          this.markers = markers;
      }.bind(this));

      this.subscribeTo('pb-geolocation', function(ev) {
          if (ev.detail.coordinates) {
              this.setProperties({
                  latitude: ev.detail.coordinates.latitude,
                  longitude: ev.detail.coordinates.longitude,
                  label: ev.detail.label
              });
          }
      }.bind(this));
  }

  ready(){
      super.ready();
  }
}

window.customElements.define(PbMap.is, PbMap);
