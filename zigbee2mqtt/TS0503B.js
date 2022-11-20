const fz = require('zigbee-herdsman-converters/converters/fromZigbee');
const tz = require('zigbee-herdsman-converters/converters/toZigbee');
const exposes = require('zigbee-herdsman-converters/lib/exposes');
const reporting = require('zigbee-herdsman-converters/lib/reporting');
const extend = require('zigbee-herdsman-converters/lib/extend');
const ota = require('zigbee-herdsman-converters/lib/ota');
const tuya = require('zigbee-herdsman-converters/lib/tuya');
const e = exposes.presets;
const ea = exposes.access;

const definition = {
    fingerprint: [{modelID: 'TS0503B', manufacturerName: '_TZ3000_i8l0nqdu'},
        {modelID: 'TS0503B', manufacturerName: '_TZ3210_a5fxguxr'},
        {modelID: 'TS0503B', manufacturerName: '_TZ3210_778drfdt'},
        {modelID: 'TS0503B', manufacturerName: '_TZ3000_g5xawfcq'},
        {modelID: 'TS0503B', manufacturerName: '_TZ3210_trm3l2aw'},
        {modelID: 'TS0503B', manufacturerName: '_TZ3210_95txyzbx'},
        {modelID: 'TS0503B', manufacturerName: '_TZ3210_odlghna1'},
        {modelID: 'TS0503B', manufacturerName: '_TZ3210_0zabbfax'}],
    model: 'TS0503B',
    vendor: 'TuYa',
    description: 'Zigbee RGB light',
    extend: extend.light_onoff_brightness_color(),
    // Requires red fix: https://github.com/Koenkk/zigbee2mqtt/issues/5962#issue-796462106
    meta: {applyRedFix: true, enhancedHue: false},
};

module.exports = definition;