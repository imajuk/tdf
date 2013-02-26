package com.imajuk.tdf
{
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
            
            //テスト用の簡易ビュー
            addChild(new GraphView(terrin));
        }
    }
}
