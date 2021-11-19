import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: station
    title: qsTr("Station")
    anchors.top: parent.top
    anchors.topMargin: parent.height * 0.1
    anchors.bottom: parent.bottom
    anchors.bottomMargin: parent.height * 0.1

    property bool started: false
    property color colorA: "#783090"
    property color colorB: "#f0d800"
    property color colorC: "#ffffff"
    property color colorD: "#0090f0"
    property alias modelA: modelA
    property alias listView: listView

    background: Rectangle {
        color: "#E6E6FA"
        opacity: 0.5
    }

    ListModel {
        id: modelA
        onLayoutChanged: listView.forceLayout()
    }

    ListView {
        id: listView
        clip: true
        anchors.fill: parent
        anchors.topMargin: (station.height / 8) * 0.15
        model: modelA
        spacing: (station.height / 8) * 0.15
        delegate: Rectangle {
            height: (station.height / 8)
            width: station.width * 0.868
            color: (((1 % pos) === 0) || ((pos % 4) === 1)) ? colorA : (((2 % pos) === 0) || ((pos % 4) === 2)) ?  colorB : (((3 % pos) === 0) || ((pos % 4) === 3))  ? colorC : colorD
            anchors.horizontalCenter: parent.horizontalCenter
            radius: width * 0.05

            Text {
                id: busId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.075
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(busID)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.15
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: timeId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.075
                anchors.left: separator.right
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(time)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.15
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: statusId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: busId.bottom
                anchors.topMargin: parent.height * 0.088
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr("Status")
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.125
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: statusValue
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: statusId.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(status)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.25
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: etaId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: busId.bottom
                anchors.topMargin: parent.height * 0.088
                anchors.left: separator.right
                anchors.leftMargin: parent.width * 0.05
                text: qsTr("ETA")
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.125
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: etaValue
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: etaId.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: separator.right
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(eta)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.25
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Rectangle {
                id: separator
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                implicitHeight: parent.height * 0.9
                implicitWidth: parent.height * 0.02
                radius: width * 0.5
                opacity: 0.5
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }
        }
    }
}
