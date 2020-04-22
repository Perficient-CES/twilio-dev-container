'use strict';

exports.handler = async function (context, event, callback) {
    const message = 'hello functions';
    console.log(message);
    callback(null, message);
};
