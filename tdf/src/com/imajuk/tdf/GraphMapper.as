package com.imajuk.tdf
{
    import flash.utils.Dictionary;
    /**
     * @author imajuk
     */
    public class GraphMapper
    {
        private var model : DirectedGraph;
        private var position : Dictionary = new Dictionary(true);

        public function GraphMapper(model : DirectedGraph)
        {
            this.model = model;
            
            // とりあえずノードの座標は簡易ビューのノード座標をハードコーディングする.
            // あとでノードの座標を指定するインターフェイスを考える
            model.crawl(function(node : GraphNode) : void
            {
                position[node] = Vector.<Number>([node.depth * 100 + 60, node.childIndex * 60]);
            });
        }

        public function getPosition(begin : GraphNode, end : GraphNode, time : Number) : Vector.<Number>
        {
            var v1 : Vector.<Number> = position[begin],
                v2 : Vector.<Number> = position[end],
                bx : Number = v1[0], by : Number = v1[1],
                ex : Number = v2[0], ey : Number = v2[1];
                
            return Vector.<Number>([bx + (ex - bx) * time, by + (ey - by) * time]);
        }
    }
}
