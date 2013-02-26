package com.imajuk.tdf
{
    /**
     * @author imajuk
     */
    public class DirectedGraph
    {
        private var _begin : GraphNode;
        public function get begin() : GraphNode
        {
            return _begin;
        }
        
        public function DirectedGraph()
        {
            _begin = new GraphNode();
        }
        
        /**
         * 始点から終点に達するまでノードを巡回する。
         * 各ノードを引数に一度だけ与えられた関数を実行する。
         */
        public function crawl(f:Function):void
        {
            _crowl(_begin, f);
        }
        private function _crowl(node:GraphNode, f:Function) : void
        {
            f(node);
            
            if(node.hasNext)
            {
                var nexts : Array = node.to,
                    i : int = 0, 
                    l : int = nexts.length;
                for (i; i < l; i++)
                {
                    _crowl(nexts[i], f);
                }
            }
        }
        
    }
}
