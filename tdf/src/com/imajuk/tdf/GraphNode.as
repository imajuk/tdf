package com.imajuk.tdf
{
    /**
     * @author imajuk
     */
    public class GraphNode
    {
        private static var sid : int;
        private var _id : int;
        public function get id() : int
        {
            return _id;
        }
        
        private var _depth : int;
        public function get depth() : int
        {
            return _depth;
        }

        private var _childIndex : uint;
        public function get childIndex() : uint
        {
            return _childIndex;
        }

        private var _cost : Number;
        public function get cost() : Number
        {
            return _cost;
        }
        
        private var _to : Array = [];
        public function get to() : Array
        {
            return _to;
        }
        
        private var _from : Array = [];
        public function get from() : Array
        {
            return _from;
        }
        
        public function GraphNode(cost : Number = 0)
        {
            _cost = cost;
            _id = sid++;
        }
        
        public function toString() : String
        {
            return "GraphNode[" + _id + "] / depth:" + _depth;
        }

        public function add(cost:Number) : GraphNode
        {
            return connect(new GraphNode(cost));
        }

        public function connect(node : GraphNode) : GraphNode
        {
            node._childIndex = _to.length;
            _to.push(node);
            node._from.push(this);
            node._depth = Math.max(node._depth, _depth + 1);
            return node;
        }

        public function get hasNext() : Boolean
        {
            return _to.length > 0;
        }
    }
}
