import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Language_Translator extends StatefulWidget {
  const Language_Translator({super.key});

  @override
  State<Language_Translator> createState() => _Language_TranslatorState();
}

class _Language_TranslatorState extends State<Language_Translator> {

  var language = ['English', 'Bengali', 'Arabic', 'Hindi'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output ="";
  TextEditingController languageController = TextEditingController();

  void translateMethod(String src, String dest, String input) async{
    GoogleTranslator translator=new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if(src=='--' || dest=='--'){
      setState(() {
        output="fail to translate";
      });
    }

  }
  String getLanguageCode(String language){
    if(language=='English'){
      return 'en';
    }else if(language=='Bengali'){
      return 'bn';
    }else if(language=='Arabic'){
      return 'ar';
    }else if(language=='Hindi'){
      return 'hi';
    }
    return '--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        title:const Text("Language Translator",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        backgroundColor:const Color(0xff10223d),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),


              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      hint: Text(
                        originLanguage,
                        style: TextStyle(color: Colors.white),
                      ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),

                    items: language.map(
                        (String dropDownStringItem){
                          return DropdownMenuItem(
                              child: Text(dropDownStringItem),
                            value: dropDownStringItem,
                          );

                        }).toList(), //Item section end

                    onChanged: (value) {
                      setState(() {
                        originLanguage=value!;
                      });
                    },

                  ),

                  SizedBox(
                    height: 40,
                  ),

                  Icon(Icons.arrow_right_alt_outlined, color: Colors.white,size: 40,),
                  SizedBox(
                    height: 40,
                  ),

                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),

                    items: language.map(
                            (String dropDownStringItem){
                          return DropdownMenuItem(
                            child: Text(dropDownStringItem),
                            value: dropDownStringItem,
                          );

                        }).toList(), //Item section end

                    onChanged: (value) {
                      setState(() {
                        destinationLanguage=value!;
                      });
                    },

                  ),



                ],
              ),

              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Pleas enter your text....',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)
                    ),
                    errorStyle: TextStyle(
                      fontSize: 15, color: Colors.red
                    )
                  ),

                  controller: languageController,
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Pleas enter text to translator';
                    }
                    return null;
                  },

                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    //style: ElevatedButton.styleFrom(primary:color(0xff2b3c5a)),
                    onPressed: () {
                      translateMethod(
                          getLanguageCode(originLanguage),
                          getLanguageCode(destinationLanguage),
                          languageController.text.toString()
                      );

                }, child: const Text("Translate")),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                padding: const EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width * 5/6 ,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black)
                ),
                child: Text(
                  "\n$output",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                ),
              )



            ],
          ),
        ),
      ),

    );
  }
}
