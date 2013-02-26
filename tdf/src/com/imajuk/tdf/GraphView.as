﻿package com.imajuk.tdf
{
    import flash.display.Graphics;
    import flash.display.Sprite;

    /**
     * @author imajuk
     */
    public class GraphView extends Sprite
    {
        public function GraphView(graph:DirectedGraph)
        {
            graph.crawl(createNodeView);
            graph.crawl(drawEdge);
        }

        private function createNodeView(begin : GraphNode) : void
        {
            var nodeView : NodeView = addChild(NodeView.getView(begin.id)) as NodeView;
            nodeView.x = begin.depth * 100 + 60;
            nodeView.y = begin.childIndex * 60;
        }
        
        public function drawEdge(begin : GraphNode) : void
        {
            var beginNode : NodeView = NodeView.getView(begin.id);
            var g : Graphics = graphics;
            g.lineStyle(0, 0);
            
            begin.to.forEach(function(next:GraphNode, ...rest) : void
            {
                var nextNode : NodeView = NodeView.getView(next.id);
                g.moveTo(beginNode.x, beginNode.y);
                g.lineTo(nextNode.x, nextNode.y);
            });
        }
    }
    
}
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import flash.text.TextFormat;
import flash.display.Sprite;
import flash.text.TextField;
import flash.display.Graphics;

class NodeView extends Sprite
{
    private static var nodes : Array = [];
    private static var g : Graphics;

    public function NodeView(id : int)
    {
        g = graphics;
        g.clear();
        g.beginFill(0);
        g.drawCircle(0, 0, 20);
        g.endFill();
        
        var tf : TextField = addChild(new TextField()) as TextField,
            tfm : TextFormat = new TextFormat();
            
        tfm.size = 20;
        tfm.color = 0xFFFFFF;
        tfm.align = TextFormatAlign.CENTER;
        
        tf.text = id.toString();
        tf.setTextFormat(tfm);
        tf.autoSize = TextFieldAutoSize.CENTER;
        tf.x = -tf.width * .5;
        tf.y = -tf.height * .5;
    }

    public static function getView(id : int) : NodeView
    {
        if (!nodes[id])
            nodes[id] = new NodeView(id);
        return nodes[id];
    }
    
}


