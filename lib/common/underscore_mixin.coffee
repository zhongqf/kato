_.mixin
  hashCode: `function(str){
    var seed = 13131;
    var hashcode = 0;

    for (i = 0; i < str.length; ++i) {
      hashcode = hashcode * seed + str.charCodeAt(i);
    }
    return (hashcode % 2971215073);
    }`

  isValid: (obj)->
    return not @isNull(obj) and not @isUndefined(obj)

  now : ->
    return new Date().getTime()
