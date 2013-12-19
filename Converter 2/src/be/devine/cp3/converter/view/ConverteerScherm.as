package be.devine.cp3.converter.view {
import be.devine.cp3.converter.Main;
import be.devine.cp3.converter.components.AllButton;
import be.devine.cp3.converter.model.AppModel;
import feathers.controls.Button;
import feathers.controls.Screen;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class ConverteerScherm extends Screen{

    //LOCATIE SPRITE SHEET
    [Embed(source="/../assets/custom/flash_assets.png")]
    protected static const ATLAS_IMAGE:Class;

    //LOCATIE XML
    [Embed(source="/../assets/custom/flash_assets.xml", mimeType="application/octet-stream")]
    protected static const ATLAS_XML:Class;

    //FONT IMPORT
    [Embed(source="/../assets/fonts/Cassannet.otf", embedAsCFF="false", fontFamily="Cassannet")]
    private static const Cassannet:Class;

    //LEGE BUTTON
    [Embed(source="/../assets/custom/lege_button.png")]
    private static const ButtonClass:Class;

    private var _legeButton:Image;

    private var _appModel:AppModel;

    private var _button:AllButton;
    private var _lijnen:Button;
    private var _nextbtn:Button;
    private var _cont:Sprite;
    private var _sizesContainer:Sprite;
    private var btnCounter:uint;

    private var _arrButtons:Array = new Array(" VAN (EUROPESE MAAT)"," NAAR","lijnen","next_button",
                                                                    "CONVERTEER","UK_grijs","US_grijs");
    private var _arrButtons2:Array = new Array();
    private var _arrxPos:Array = new Array(90,95,90,280,90,45,145);
    private var _arryPos:Array = new Array(100,460,50,550,0,530,530);

    //MAN hemd broek schoenen
    private var _arrManHemdEU:Array = [36, 38, 40, 42, 44, 46, 48];     //7 items
    private var _arrManHemdUS:Array = [14, 14.5, 15, 15.5, 16, 16.5, 17];
    private var _arrManHemdUK:Array = [14, 14.5, 15, 15.5, 16, 16.5, 17];

    private var _arrManBroekEU:Array = [46, 48, 50, 52, 54, 56, 58];    //7 items
    private var _arrManBroekUS:Array = [30, 32, 34, 36, 38, 40, 42];
    private var _arrManBroekUK:Array = [30, 32, 34, 36, 38, 40, 42];

    private var _arrManSchoenenEU:Array = [38.5, 39, 40, 41, 42, 43, 44, 45];   //8 items
    private var _arrManSchoenenUS:Array = [6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10];
    private var _arrManSchoenenUK:Array = [6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5];

    //VROUW kleed schoenen
    private var _ArrVrouwKleedEU:Array = [36, 38, 40, 42, 44, 46, 48];  //7 items
    private var _ArrVrouwKleedUS:Array = [6, 8, 10, 12, 14, 16, 18];
    private var _ArrVrouwKleedUK:Array = [8, 10, 12, 14, 16, 18, 20];

    private var _ArrVrouwSchoenEU:Array = [37, 37.5, 38, 39, 39.5, 40, 41, 41.5]; //8 items
    private var _ArrVrouwSchoenUS:Array = [6, 6.5, 7, 7.5, 8, 8.8, 9, 9.5];
    private var _ArrVrouwSchoenUK:Array = [4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5];


    public function ConverteerScherm() {
        trace("[ConverteerScherm] construct");

    }
    override protected function draw():void{

    }

    override protected function initialize():void{
        trace("[ConverteerScherm] element dat binnenkomt " + Main.selectedItem);
        //var binnenkomendKledingstuk:AllButton = Main.selectedItem as AllButton;
        //var binnenkomendKledingstuk = _main.aangekliktKledingsstuk;
        //this.addEventListener(Main.selectedItem, buttonClickedHandler);

        var main:Main = new Main();
        var a:String = main.aangekliktKledingstuk;
        trace("jaaa " + a);

        /*switch (binnenkomendKledingstuk){
            case "hemd":
                trace("jaaa + hemd");
                break;
        }*/

        _appModel = AppModel.getInstance();

        _cont = new Sprite();

        var texture:Texture = Texture.fromBitmap(new ATLAS_IMAGE());
        var xml:XML = XML(new ATLAS_XML());
        var _atlas:TextureAtlas = new TextureAtlas(texture, xml);

        //CREATE NUMERIC BUTTONS
        _sizesContainer = new Sprite();
        addChild(_sizesContainer);
        _sizesContainer.x = 100;
        _sizesContainer.y = 270;
        var xPos:uint = 0;
        var yPos:uint = 0;

        for each(var element:Number in _arrManSchoenenEU){
            _legeButton = Image.fromBitmap(new ButtonClass());
            _sizesContainer.addChild(_legeButton);

            var starlingTextField:starling.text.TextField =
                    new starling.text.TextField(
                            100, 100, element + "", "Verdana", 30, 0x75b699
                    );
            starlingTextField.x = xPos;
            starlingTextField.y = yPos;
            _legeButton.x = xPos;
            _legeButton.y = yPos;

            xPos += starlingTextField.width - 1;

            btnCounter += 1;

            if(btnCounter == 3 || btnCounter == 6){
                xPos = 0;
                yPos += starlingTextField.height - 1;
            }

            _sizesContainer.addChild(starlingTextField);

        }

        //CREATE BUTTONS
        var arrayCounter:Number = 0;
        for each (var value:String in _arrButtons) {

            _button = new AllButton(value, _arrxPos[arrayCounter]+103, _arryPos[arrayCounter]+80, texture, xml);
            addChild(_button);
            _arrButtons2.push(_button);
            arrayCounter += 1;
        }

        _lijnen = _arrButtons2[0];
        _nextbtn = _arrButtons2[3];
        trace(_nextbtn)
        addChild(_nextbtn);
        _nextbtn.addEventListener(starling.events.Event.TRIGGERED, button_triggeredHandler);

    }

    private function button_triggeredHandler(event:starling.events.Event):void {
        dispatchEventWith("knopklik3", true, _nextbtn);
    }

    private function buttonClickedHandler(event:Event, path:String):void{
        trace("[ConverteerScherm] geklikt op: " + path);

    }

}
}
