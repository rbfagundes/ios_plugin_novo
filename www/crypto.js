/**
 * Phonegap FullGauge Crypto plugin
 * 
 * 
 * 
 * var Crypto = { sum: function (text, success, fail) { //var retorno = {};
 * //retorno.result = 20; //success(retorno); //return true; return
 * cordova.exec(success, fail, 'TestePlugin', 'sum', text); //return
 * cordova.exec(success, fail, 'Crypto', 'sum', text); },
 * 
 * crypt: function (text, success, fail) { console.log(text); return
 * cordova.exec(success, fail, 'Crypto', 'crypt', [text]); },
 * 
 * decrypt: function (text, success, fail) {
 * 
 * return cordova.exec(success, fail, 'Crypto', 'decrypt', [text]); }, //
 * decryptBase64: function (text, success, fail) { // // return
 * cordova.exec(success, fail, 'Crypto', 'decryptBase64', [text]); // },
 * 
 * decodeBase64: function (text, success, fail) {
 * 
 * return cordova.exec(success, fail, 'Crypto', 'decodeBase64', [text]); },
 * 
 * encodeBase64: function (text, success, fail) {
 * 
 * return cordova.exec(success, fail, 'Crypto', 'encodeBase64', [text]); } };
 */

module.exports = {
	crypt : function(text, success, fail) {
		console.log(text);
		cordova.exec(success, fail, 'Crypto', 'crypt', [ text ]);
	},

	decrypt : function(text, success, fail) {
		cordova.exec(success, fail, 'Crypto', 'decrypt', [ text ]);
	},

	decryptBase64 : function(text, success, fail) {
		cordova.exec(success, fail, 'Crypto', 'decryptBase64', [ text ]);
	},

	decodeBase64 : function(text, success, fail) {
		cordova.exec(success, fail, 'Crypto', 'decodeBase64', [ text ]);
	},

	encodeBase64 : function(text, success, fail) {
		cordova.exec(success, fail, 'Crypto', 'encodeBase64', [ text ]);
	}
};

};