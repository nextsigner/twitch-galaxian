import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    width: w
    height: w
    property int numShot: 0
    property int w: app.fs*3
    property color c1: 'red'
    Behavior on x{
        NumberAnimation{duration: 100}
    }
    Behavior on y{
        NumberAnimation{duration: 100}
    }
    Behavior on rotation{
        NumberAnimation{duration: 100}
    }
    Rectangle{
        width: r.w
        height: width
        color: 'transparent'
        //border.width: 1
        //border.color: 'red'
    }
    Image {
        id: img1
        source: "file:./img/p1.png"
        anchors.centerIn: r
        anchors.verticalCenterOffset: r.height*0.25
        width: r.w*0.75
        height: r.w*0.75
    }
    ColorOverlay {
        id: co
        anchors.fill: img1
        source: img1
        color: app.c2
        opacity: 0.0
        onOpacityChanged:{
            if(opacity===1.0){
                opacity=0.0
            }
        }
        Behavior on opacity{
            NumberAnimation{duration: 300}
        }
    }
    function u(){
        if(y<100)return
        y-=10
    }
    function d(){
        if(y>r.parent.height-r.height)return
        y+=10
    }
    function r(){
        if(x>parent.width-width)return
        x+=10
    }
    function l(){
        if(r.x-10<0)return
        r.x-=10
    }
    function rot(px, py){
        var	dx = parseInt(r.x-r.width*0.5) - px,
        dy = parseInt(r.y+r.width*0.5) - py;
        var theta = Math.atan2(dy, dx); // range (-PI, PI]
        theta *= 180 / Math.PI;
        r.rotation= theta-90
    }
    function recept(){
        co.opacity=1.0
    }
    function s(){
        ap.stop()
        let ws=app.fs*0.25
        let comp=Qt.createComponent("M1.qml")
        let obj=comp.createObject(r.parent, {w: ws, x: r.x+r.width*0.5-ws*0.5, y:r.y+r.height, objectName: 'obj'+r.numShot})
        //let obj=comp.createObject(r.parent, {w: ws, x: r.x+r.width*0.5-ws*0.5, y:r.y, objectName: 'obj1'})
        ap.play()
        r.numShot++
    }
    function s2(px, py){
        ap.stop()
        let ws=app.fs*0.25
        let comp=Qt.createComponent("M2.qml")
        let obj=comp.createObject(r.parent, {w: ws, x: r.x+r.width*0.5-ws*0.5, y:r.y+r.height*0.5, xd: px, yd: py, objectName: 'obj'+r.numShot})
        //let obj=comp.createObject(r.parent, {w: ws, x: r.x+r.width*0.5-ws*0.5, y:r.y, objectName: 'obj1'})
        ap.play()
        r.numShot++
    }
}
