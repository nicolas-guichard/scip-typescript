// < definition pure-js 1.0.0 src/`exports.js`/

exports.SomeExportedClass = class LocalClassName {
//^^^^^ reference local 1
//      ^^^^^^^^^^^^^^^^^ definition local 2
//                                ^^^^^^^^^^^^^^ reference local 1
  method() {}
//^^^^^^ definition local 4
}

module.exports.SomeAnonymousClass = class /*anonymous*/ {
//^^^^ reference local 6
//     ^^^^^^^ reference pure-js 1.0.0 src/`exports.js`/
//             ^^^^^^^^^^^^^^^^^^ definition local 8
  method() {}
//^^^^^^ definition local 11
}

exports.someFunc = function localFuncName() {}
//^^^^^ reference local 14
//      ^^^^^^^^ definition local 15
//                          ^^^^^^^^^^^^^ reference local 16
exports.someAnonymousFunc = function () /*anonymous*/ {}
//^^^^^ reference local 19
//      ^^^^^^^^^^^^^^^^^ definition local 20

exports.someArrowFunc = () => {}
//^^^^^ reference local 23
//      ^^^^^^^^^^^^^ definition local 24

exports.someValue = 4
//^^^^^ reference local 27
//      ^^^^^^^^^ definition local 28

