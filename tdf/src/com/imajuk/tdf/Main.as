package com.imajuk.tdf
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    public class Main extends Sprite
    {
        private var terrin : DirectedGraph;

        public function Main()
        {
            // テスト用の地形作成
            terrin = new DirectedGraph();
            // 敵軍進軍始点（ノードA）
            var node_A : GraphNode = terrin.begin;
            // ノードAにノードBを追加
            var node_B : GraphNode = node_A.add(3);
            // ノードBにノードCを追加
            var node_C : GraphNode = node_B.add(5);
            // ノードBにノードDを追加
            var node_D : GraphNode = node_B.add(5);
            // ノードCにノードEを追加
            var node_E : GraphNode = node_C.add(5);
            // ノードEに敵軍終点（ノードF）を追加
            var node_F : GraphNode = node_E.add(5);
            // ノードDとノードFを連結
            node_D.connect(node_F);
            
            // グラフを空間にマップするオブジェクト
            var mapper:GraphMapper = new GraphMapper(terrin);

            // テスト用の簡易ビュー
            var view:Sprite = addChild(new GraphView(terrin, mapper)) as Sprite;
            
            // ビューの各ノード間の経路をポイント
            var nodes:Array = [
                [node_A, node_B,  0], //ノードAからノードBまでの経路上で0%の位置
                [node_B, node_C, .2], //ノードBからノードCまでの経路上で20%の位置
                [node_B, node_D, .4], //ノードBからノードDまでの経路上で40%の位置
                [node_C, node_E, .6], //ノードCからノードEまでの経路上で60%の位置
                [node_D, node_F, .8], //ノードDからノードFまでの経路上で80%の位置
                [node_E, node_F,  1]  //ノードEからノードFまでの経路上で100%の位置
            ];
            nodes.forEach(function(a:Array, ...rest) : void
            {
                var v : Vector.<Number> = mapper.getPosition(a[0], a[1], a[2]);
                var p : DisplayObject = view.addChild(new TestPoint());
                p.x = v[0];
                p.y = v[1];
            });
        }
    }
}
import flash.display.Shape;

class TestPoint extends Shape
{
    public function TestPoint() {
        graphics.beginFill(0x0000FF, .5);
        graphics.drawCircle(0, 0, 30);
        graphics.endFill();
    }
}