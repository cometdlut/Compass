﻿import QtQuick 2.0
import QtCanvas3D 1.1
import QtQuick.Controls 1.4

import "SpacePath.js" as GLcode

Item {
    id: container
    width: 1400
    height: 900
    visible: true

    Label {
        z: 1000
        anchors {
            top: parent.top
            right: parent.right
            rightMargin: 120
        }
        width: 30
        height: 20
        text: "FPS: " + canvas3d.fps
        font.pointSize: 20
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }


//        flickableItem: contentRect
    Rectangle {
        id:    controller
        z:     10
        anchors.top: parent.top
        property int margintop: 10
        property int marginleft: 30
        property bool show: true

        width: 215
        height: parent.height
        color: Qt.rgba(0.68, 0.68, 0.68, 0.5)

        Flickable {
            id: view
            width: 200
            height: parent.height
            contentWidth: 200
            contentHeight: container.height


            Rectangle {
                id: cameraItem
                color: controller.color
                border.color: Qt.rgba(0.68, 0.68, 0.68, 1)
                border.width: 2
                width:  parent.width
                height: calcHeight(this, 1)
                anchors {
                    top: parent.top
                    topMargin: controller.margintop * 0.5
                    left: parent.left
                }
                Item {
                    id: cameraItem0
                    width: parent.width
                    height: calcHeight(this)

                    MySlider {
                        id: camTheta
                        objectName: "cam_theta"
                        anchors {
                            top: parent.top
                            topMargin: controller.margintop * 0.5
                        }

                        width: parent.width
                        text: "摄像机θ角："
                        maxValue: 180.0
                        minValue: 0.0
                        onValueChanged: {
                            argItem.cam_theta = this.value;
                            GLcode.rotateCamera(argItem);
                        }
                    }

                    MySlider {
                        id: camBeta
                        objectName: "cam_beta"
                        anchors {
                            top: camTheta.bottom
                            topMargin: controller.margintop
                        }
                        width: parent.width
                        text: "摄像机β角："
                        maxValue: 180.0
                        minValue: -180.0
                        onValueChanged: {
                            argItem.cam_beta = this.value;
                            GLcode.rotateCamera(argItem);
                        }
                    }

                    MySlider {
                        id: camDis
                        objectName: "cam_dis"
                        anchors {
                            top: camBeta.bottom
                            topMargin: controller.margintop
                        }
                        width: parent.width
                        text: "摄像机距原点："
                        maxValue: 100.0
                        minValue: 0.5
                        onValueChanged: GLcode.rotateCamera(argItem);
                    }
                }  // cameraItem 0

                Item {
                    id: cameraItem1
                    width: parent.width
                    height: calcHeight(this)
                    visible: false

                    MySlider {
                        id: cameraXPos
                        anchors {
                            top: cameraItem1.top
                            topMargin: controller.margintop * 0.5
                        }
                        enabled: false
                        width: parent.width
                        text: "摄像机X："
                        maxValue: 150.0
                        minValue: -150.0
                    }

                    MySlider {
                        id: cameraYPos
                        anchors {
                            top: cameraXPos.bottom
                            topMargin: controller.margintop
                        }
                        enabled: false
                        width: parent.width
                        text: "摄像机Y："
                        maxValue: 150.0
                        minValue: -150.0
                    }

                    MySlider {
                        id: cameraZPos
                        anchors {
                            top: cameraYPos.bottom
                            topMargin: controller.margintop
                        }
                        enabled: false
                        width: parent.width
                        text: "摄像机Z："
                        maxValue: 150.0
                        minValue: -150.0
                    }
                }  // cameraItem 1
            }   // cameraItem

            Rectangle {
                id: canvasSetting
                color: controller.color
                border.color: Qt.rgba(0.68, 0.68, 0.68, 1)
                border.width: 2
                width: parent.width
                height: calcHeight(this)
                anchors {
                    top: cameraItem.bottom
                    topMargin: controller.margintop
                    left: parent.left
                }

                MySlider {
                    id: ballRadius
                    anchors {
                        top: canvasSetting.top
                        topMargin: controller.margintop * 0.5
                    }
                    width: parent.width
                    text: "参考球半径："
                    maxValue: 15
                    minValue: 0.5
                    btnSize: 0.5
                }

                MySlider {
                    id: ballAlpha
                    anchors {
                        top: ballRadius.bottom
                        topMargin: controller.margintop
                    }
                    width: parent.width
                    text:  "球面透明度"
                    maxValue: 1.0
                    minValue: 0.1
                    btnSize: 0.1
                }

                MySlider {
                    id: pointSize
                    anchors {
                        top: ballAlpha.bottom
                        topMargin: controller.margintop
                    }
                    width: parent.width
                    text: "指示器大小："
                    maxValue: 1
                    minValue: 0.1
                    btnSize: 0.1
                }

                MySlider {
                    id: pathWidth
                    anchors {
                        top: pointSize.bottom
                        topMargin: controller.margintop
                    }
                    width: parent.width
                    text: "轨迹宽度："
                    maxValue: 50
                    minValue: 1
                    stepSize: 1.0
                }

                MySlider {
                    id: pathGap
                    anchors {
                        top: pathWidth.bottom
                        topMargin: controller.margintop
                    }
                    width: parent.width
                    text: "路径间隔："
                    maxValue: 10
                    minValue: 1
                    stepSize: 1.0
                }

                MySlider {
                    id: circleSize
                    anchors {
                        top: pathGap.bottom
                        topMargin: controller.margintop
                    }
                    width: parent.width
                    text: "参考圆圈大小："
                    value: 0.3
                    maxValue: 1
                    minValue: 0.1
                    btnSize: 0.1
                }

                MySlider {
                    id: craftSize
                    anchors {
                        top: circleSize.bottom
                        topMargin: controller.margintop
                    }
                    width: parent.width
                    text: "模拟器大小:"
                    maxValue: 1
                    minValue: 0.01
                    value   : 0.3
                    btnSize: 0.1
                }
            }  // canvasSetting

            Rectangle {
                id: drawMode
                color: controller.color
                border.color: Qt.rgba(0.68, 0.68, 0.68, 1)
                border.width: 2
                width: parent.width
                height: calcHeight(this, 2)
                anchors {
                    top: canvasSetting.bottom
                    topMargin: controller.margintop
                    left: parent.left
                }

                RadioButton {
                    id: lineRB
                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    width: 20
                    height: 20
                    text: "line"
                    onClicked: {
                        argItem.draw_mode = text;
                    }
                }

                RadioButton {
                    id: surfaceRB
                    anchors {
                        top: lineRB.bottom
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    width: 20
                    height: 20
                    text: "surface"
                    onClicked: {
                        argItem.draw_mode = text;
                    }
                }

                RadioButton {
                    id: lessLineRB
                    anchors {
                        top: surfaceRB.bottom
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    width: 20
                    height: 20
                    text: "lessLine"
                    onClicked: {
                        argItem.draw_mode = text;
                    }
                }

            }   // drawMode

            Rectangle {
                id: checkBoxItem
                color: controller.color
                border.color: Qt.rgba(0.68, 0.68, 0.68, 1)
                border.width: 2
                width: parent.width
                property int bheight: 15
                height: calcHeight(this, 5)
                anchors {
                    top: drawMode.bottom
                    topMargin: controller.margintop
                    left: parent.left
                }

                CheckBox {
                    id: pathEnableBox
                    height: parent.bheight
                    text  : "绘制路径"

                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    checked: true
                    onCheckedChanged: {
                        argItem.enable_path = checked;
                        pathGap.enabled     = checked;
                        pathWidth.enabled   = checked;
                    }
                }

                CheckBox {
                    id: simBox
                    height: parent.bheight
                    text: "绘制模拟器"

                    anchors {
                        top: pathEnableBox.bottom
                        left: parent.left
                        topMargin: 5
                        leftMargin: controller.marginleft
                    }
                    checked: true
                    onCheckedChanged: {
                        argItem.enable_sim = checked;
                        craftSize.enabled  = checked;
                    }
                }

                CheckBox {
                    id: axisBox
                    height: parent.bheight
                    text: "球坐标系"
                    checked: true

                    anchors {
                        top: simBox.bottom
                        topMargin: 5
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    onCheckedChanged: {
                        cameraItem0.visible = checked;
                        cameraItem1.visible = !checked;
                    }
                }

                CheckBox {
                    id: calibrationBox
                    height: parent.bheight
                    text: "显示修正圆圈"
                    checked: true

                    anchors {
                        top: axisBox.bottom
                        topMargin: 5
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    onCheckedChanged: {
                        argItem.calibration = checked;
                        circleSize.enabled  = checked;
                    }
                }
            }  // checkBoxItem

            Rectangle {
                id: operateItem
                color: controller.color
                border.color: Qt.rgba(0.68, 0.68, 0.68, 1)
                border.width: 2
                width: parent.width
                height: calcHeight(this, 5)
                anchors {
                    top: checkBoxItem.bottom
                    topMargin: controller.margintop
                    left: parent.left
                }

                Button {
                    id: resetCameraBtn
                    width: 70
                    height: 20
                    text: "重置摄像机"
                    anchors {
                        top: parent.top
                        topMargin: 3
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    onClicked: {
                        argItem.cam_theta = 45
                        argItem.cam_beta  = 90

                        GLcode.rotateCamera(argItem);
                        GLcode.reset(argItem);
                    }
                }

                Button {
                    id: resetPathBtn
                    width: 70
                    height: 20
                    text: "重置路径"
                    anchors {
                        top: resetCameraBtn.bottom
                        topMargin: 5
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    onClicked: {
                        console.log("[Info] Reset all path.")
                        GLcode.resetAllPath();
                    }
                }

                Button {
                    id: recordBtn
                    width: 60
                    height: 20
                    text: "打点"
                    anchors{
                        top: resetPathBtn.bottom
                        topMargin: 5
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    onClicked: {
                        recordAPoint();
                    }
                }

                Button {
                    id: resetRecordButton
                    width: 60
                    height: 20
                    text: "重置打点"
                    anchors {
                        top: recordBtn.bottom
                        topMargin: 5
                        left: parent.left
                        leftMargin: controller.marginleft
                    }
                    onClicked: {
                        GLcode.resetRecord();
                    }
                }
            }  // end of operateItem

            Rectangle {
                id: posItem
                color: controller.color
                border.color: Qt.rgba(0.68, 0.68, 0.68, 1)
                border.width: 2
                width: parent.width
                height: calcHeight(this)
                anchors {
                    top : operateItem.bottom
                    topMargin: controller.margintop
                    left: parent.left
                }

                MySlider {
                    id: pitch
                    anchors {
                        top: parent.top
                        topMargin: controller.margintop * 0.5
                    }
                    width: parent.width
                    text: "pitch："
                    maxValue: 90
                    minValue: -90
        //                value   : 0
                }

                MySlider {
                    id: heading
                    anchors {
                        top: pitch.bottom
                        topMargin: controller.margintop
                    }
                    width: parent.width
                    text: "heading:"
                    maxValue: 180
                    minValue: -180
                    value   : 0
                }

                MySlider {
                    id: roll
                    anchors {
                        top: heading.bottom
                        topMargin: controller.margintop
                    }
                    width: parent.width
                    text: "roll:"
                    maxValue: 180
                    minValue: -180
                    value   : 0
                }

            }  // posItem

            Item {
                // this item is used for calculate the height of Flickable item
                visible: false
                Component.onCompleted: {
                    view.contentHeight = calcHeight(view.contentItem);  // use contentItem to set contentHeight
                }
            }

            // Only show the scrollbars when the view is moving.
            states: State {
                name: "ShowBars"
                when: view.movingVertically
                PropertyChanges { target: verticalScrollBar; opacity: 1 }
            }

            transitions: Transition {
                NumberAnimation { properties: "opacity"; duration: 1000 }
            }

        }
        ScrollBar {
            id: verticalScrollBar
            width: 10; height: view.height-3
            anchors.right: controller.right
            opacity: 0.1
            orientation: Qt.Vertical
            position: view.visibleArea.yPosition
            pageSize: view.visibleArea.heightRatio
        }
        Button {
            id: controlBtn
            width: 18
            height: 18
            text: "<"
            Image {
                id: arrowBtnImg
                source: "qrc:/img/arrow.png"
                width:  parent.width
                height: parent.height
            }
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.right
            }

            onClicked: {
                if( controller.show ) {
//                    controller.x -= controller.width;
//                    controller_hide.running = true
                    controller_hide.start();
                    arrowBtnImg.rotation = 180
                    text = ">";
                } else {
                    controller_show.start();
                    text = "<";
                    arrowBtnImg.rotation = 0
                }
                controller.show = !controller.show;
            }
        }

        NumberAnimation {
            id:      controller_show
            running: false
            target:  controller
            properties: "x";
            from: -controller.width+controlBtn.width*0.5
            to: 0
            duration: 2500
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            id:      controller_hide
            running: false
            target:  controller
            properties: "x";
            from: 0;
            to: -controller.width+controlBtn.width*0.5
            duration: 2500
            easing.type: Easing.OutQuad
        }
    }

    MouseArea {
        id: mouseListener
        anchors {
            top: parent.top
            left:controller.right
            right: parent.right
            bottom: parent.bottom
        }
        property int lpx: 0
        property int lpy: 0
        property int mousex: 1
        property int mousey: 1
        onMouseXChanged: {
            if(mouseListener.pressed) {
                GLcode.mouseDraged(argItem, mouseListener, container);
                lpx = mouseListener.mouseX
            }
        }
        onMouseYChanged: {
            if(mouseListener.pressed) {
                GLcode.mouseDraged(argItem, mouseListener, container);
                lpy = mouseListener.mouseY;
            }
        }
        /** onPressed and onReleased 实现拖拽操作 */
        onPressed: {
//            console.log("pressed  ==> " + mouseListener.mouseX + " ,  " + mouseListener.mouseY)
            lpx = mouseListener.mouseX;
            lpy = mouseListener.mouseY;
        }

        onWheel: {
            argItem.cam_dis -= wheel.angleDelta.y / 120;
//
        }

        onDoubleClicked: {
            recordAPoint();
        }
    }

//    FileContentItem {
//        id: content
//        filename: ":/obj/craft.obj"   // default is craft.obj
//        property bool ready: false
//        Component.onCompleted: {
//            ready = true;
//            GLcode.readFile = processContent;
//        }

//        function processContent(source, process) {
//            while( !ready ) {
//                ;
//            }

//            if( source !== undefined ) {
//                filename = source;
//            }
//            console.time('Read file: "' + source + '"');
//            process(getContent());
//            console.timeEnd('Read file: "' + source + '"');
//            clearContent();  // save memory
//        }
//    }

    /**
      * this item is just used for reserved variables
    **/
    Item {
        id: argItem
        visible: false
        property alias  cam_dis:      camDis.value
//        property alias  cam_theta:   camTheta.value
//        property alias  cam_beta:    camBeta.value
        property alias  cam_x:        cameraXPos.value
        property alias  cam_y:        cameraYPos.value
        property alias  cam_z:        cameraZPos.value
        property alias  ball_radius:  ballRadius.value
        property alias  point_size:   pointSize.value
        property alias  path_width:   pathWidth.value
        property alias  path_gap:     pathGap.value
        property alias  ball_alpha:   ballAlpha.value
        property alias  circle_size:  circleSize.value
        property alias  calibration:  calibrationBox.checked
        property alias  enable_path:  pathEnableBox.checked
        property alias  craft_size:   craftSize.value
        property alias  enable_sim:   simBox.checked

        /* 只需要航向角和俯仰角即可确定传感器方向向量(默认向量长度为球体半径, 4) */
        property alias  heading: heading.value
        property alias  pitch:   pitch.value
        property double roll:    roll.value
        property double cam_theta:   0.0
        property double cam_beta:    0.0
        property double heading_offset: 0
        property double vector_length:  4
        property var    light_direction: [0.35, 0.35, 0.7]
        property string draw_mode: "line"

        onCam_thetaChanged: {
            camTheta.value = this.cam_theta
        }

        onCam_betaChanged: {
            camBeta.value  = this.cam_beta
        }

        onDraw_modeChanged: {
            ballAlpha.enabled = ( draw_mode !== "line");
            var checkItem = drawMode;
            var child;

            for(var i in drawMode.children) {
                child = drawMode.children[i];
                child.checked = false;
                if( child.text === draw_mode ) {
                    checkItem = child;
                }
            }
            checkItem.checked = true;
        }
    }

    Canvas3D {
        id: canvas3d
        anchors.fill: parent
        focus: true
        property bool stop: true
//        renderOnDemand: true

        /* 只需要航向角和俯仰角即可确定传感器方向向量(默认向量长度为球体半径, 4) */
        // 渲染节点就绪时，进行初始化时触发
        onInitializeGL: {
            GLcode.initUI(argItem);
            GLcode.initializeGL(canvas3d, argItem);
        }

        // 当 canvas3d 准备好绘制下一帧时触发
        onPaintGL: {
            if( stop ) {
                return;
            }

            GLcode.paintGL(canvas3d, argItem);
        }

        onResizeGL: {
            GLcode.resizeGL(canvas3d)
        }
    }

    Connections {
        target: dataSource
        onDataChanged: {
            console.log("dataSource heading changed:  " + dataSource.getHeading());
        }
    }

    Connections {
        target: window

        onWindowStateChanged: {
            if( window.visibility == window.Hidden || window.visibility == window.Minimized ) {
                // it can decrease resource consuming when not minimized or hidden
                console.log("[Info] windos state changed:  now hidden or minimized");
                canvas3d.stop = true;
            } else {
//                console.log("[Info] windos state changed:  now visible");
                canvas3d.stop = false;
            }
        }
    }

    // this function is called by C++ layer and connects JS layer
    function recordAPoint() {
        GLcode.record();
    }

    /**
      * this is for height calculating,
      * while children items would be initialized after parent,
      * it should be called after everything being ok
    **/
    function calcHeight(item, margin) {
        var height  = 0;
        var clength = 0;
        for(var i = 0; i < item.children.length; i++) {
            if( item.children[i].visible ) {
                height += item.children[i].height;
                clength ++;
            }
        }

        if( margin === undefined ) {
            margin = controller.margintop;
        }

        return height + clength * margin;
    }

}
