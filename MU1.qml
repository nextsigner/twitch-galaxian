import QtQuick 2.0

Item {
    id: r
    width: w
    height: width
    property int w: app.fs
    property int vel: 3000
    property int xd: 0
    property int yd: 0
    onYChanged:{
        if(y>r.parent.height){
            r.destroy(1)
        }
    }
    Behavior on x{
        NumberAnimation{duration: r.vel;}
    }
    Behavior on y{
        NumberAnimation{duration: r.vel;}
    }
    Rectangle{
        id: bg
        anchors.fill: r
        color: 'red'
        radius: width*0.5
    }
    Timer{
        running: true
        repeat: true
        interval: 50
        onTriggered: {
            if(r.y>=p1.y+p1.height*0.25&&r.x-r.width*0.5>=p1.x&&r.x-r.width*0.5<=p1.x+p1.width){
                r.opacity=0.5
                //r.width=100
                //r.x=r.x-50
            }
        }
    }
    Component.onCompleted: {
        r.x=r.xd
        r.y=r.yd
    }
}
