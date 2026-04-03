// < definition pure-js 1.0.0 src/`exports.js`/

exports.SomeExportedClass = class LocalClassName {
//^^^^^ reference local 2
//      ^^^^^^^^^^^^^^^^^ definition local 3
//                                ^^^^^^^^^^^^^^ reference local 2
  method() {}
//^^^^^^ definition local 4
}

module.exports.SomeAnonymousClass = class /*anonymous*/ {
//^^^^ reference local 9
//     ^^^^^^^ reference pure-js 1.0.0 src/`exports.js`/
//             ^^^^^^^^^^^^^^^^^^ definition local 7
  method() {}
//^^^^^^ definition local 11
}

exports.someFunc = function localFuncName() {}
//^^^^^ reference local 14
//      ^^^^^^^^ definition local 14
//                          ^^^^^^^^^^^^^ reference local 15
exports.someAnonymousFunc = function () /*anonymous*/ {}
//^^^^^ reference local 18
//      ^^^^^^^^^^^^^^^^^ definition local 18

exports.someArrowFunc = () => {}
//^^^^^ reference local 21
//      ^^^^^^^^^^^^^ definition local 21

exports.someValue = 4
//^^^^^ reference local 24
//      ^^^^^^^^^ definition local 24

