"use client"

import { useEffect, useState } from "react"
import { getSupabaseClient } from "@/lib/supabase/client"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { PlusCircle, Edit2, Trash2, Package } from "lucide-react"

interface Tool {
  id: number
  codigo: string
  nome: string
  descricao: string
  marca: string
  modelo: string
  preco_custo: number
  preco_venda: number
  estoque_minimo: number
  estoque_maximo: number
  ativo: boolean
  estoque_atual?: number
}

export default function FerramentasPage() {
  const [tools, setTools] = useState<Tool[]>([])
  const [estoque, setEstoque] = useState<Record<number, number>>({})
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState("")

  useEffect(() => {
    fetchTools()
  }, [])

  const fetchTools = async () => {
    try {
      setLoading(true)
      const supabase = getSupabaseClient()

      if (!supabase) {
        console.error("Supabase client not initialized")
        return
      }

      const { data: toolsData, error: toolsError } = await supabase
        .from("produtos")
        .select("*")
        .eq("categoria_id", 8)
        .eq("ativo", true)

      if (toolsError) throw toolsError

      const { data: stockData, error: stockError } = await supabase
        .from("estoque")
        .select("produto_id, quantidade_atual")
        .in(
          "produto_id",
          (toolsData || []).map((t) => t.id),
        )

      if (stockError) throw stockError

      const stockMap: Record<number, number> = {}
      ;(stockData || []).forEach((item) => {
        stockMap[item.produto_id] = item.quantidade_atual || 0
      })

      setTools(toolsData || [])
      setEstoque(stockMap)
    } catch (error) {
      console.error("Erro ao buscar ferramentas:", error)
    } finally {
      setLoading(false)
    }
  }

  const filteredTools = tools.filter(
    (tool) =>
      tool.nome.toLowerCase().includes(searchTerm.toLowerCase()) ||
      tool.codigo.toLowerCase().includes(searchTerm.toLowerCase()) ||
      tool.marca.toLowerCase().includes(searchTerm.toLowerCase()),
  )

  const totalValue = tools.reduce((sum, tool) => {
    return sum + (estoque[tool.id] || 0) * tool.preco_custo
  }, 0)

  const totalItems = Object.values(estoque).reduce((sum, qty) => sum + qty, 0)

  return (
    <main className="min-h-screen bg-background p-8">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="flex justify-between items-center mb-8">
          <div>
            <h1 className="text-4xl font-bold mb-2">Ferramentas</h1>
            <p className="text-muted-foreground">Gerenciamento de estoque de ferramentas</p>
          </div>
          <Button size="lg" className="gap-2">
            <PlusCircle className="w-5 h-5" />
            Nova Ferramenta
          </Button>
        </div>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-muted-foreground">Total de Itens</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-3xl font-bold">{totalItems}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-muted-foreground">Tipos de Ferramentas</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-3xl font-bold">{tools.length}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-muted-foreground">Valor Total em Estoque</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-3xl font-bold">
                R$ {totalValue.toLocaleString("pt-BR", { minimumFractionDigits: 2 })}
              </p>
            </CardContent>
          </Card>
        </div>

        {/* Search */}
        <div className="mb-6">
          <Input
            placeholder="Buscar por nome, código ou marca..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="max-w-md"
          />
        </div>

        {/* Tools Table */}
        <Card>
          <CardHeader>
            <CardTitle>Ferramentas em Estoque</CardTitle>
            <CardDescription>
              {filteredTools.length} de {tools.length} ferramentas
            </CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? (
              <p className="text-center py-8 text-muted-foreground">Carregando...</p>
            ) : filteredTools.length === 0 ? (
              <p className="text-center py-8 text-muted-foreground">Nenhuma ferramenta encontrada</p>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead>
                    <tr className="border-b">
                      <th className="text-left py-3 px-4 font-semibold">Código</th>
                      <th className="text-left py-3 px-4 font-semibold">Nome</th>
                      <th className="text-left py-3 px-4 font-semibold">Marca</th>
                      <th className="text-left py-3 px-4 font-semibold">Preço Custo</th>
                      <th className="text-left py-3 px-4 font-semibold">Preço Venda</th>
                      <th className="text-center py-3 px-4 font-semibold">
                        <Package className="w-4 h-4 inline" /> Estoque
                      </th>
                      <th className="text-left py-3 px-4 font-semibold">Mín/Máx</th>
                      <th className="text-center py-3 px-4 font-semibold">Ações</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filteredTools.map((tool) => {
                      const currentStock = estoque[tool.id] || 0
                      const isLow = currentStock <= tool.estoque_minimo
                      const isExcess = currentStock >= tool.estoque_maximo

                      return (
                        <tr key={tool.id} className="border-b hover:bg-accent/50">
                          <td className="py-3 px-4 font-mono text-sm">{tool.codigo}</td>
                          <td className="py-3 px-4">
                            <div>
                              <p className="font-medium">{tool.nome}</p>
                              <p className="text-sm text-muted-foreground">{tool.descricao}</p>
                            </div>
                          </td>
                          <td className="py-3 px-4">{tool.marca}</td>
                          <td className="py-3 px-4">R$ {tool.preco_custo.toFixed(2)}</td>
                          <td className="py-3 px-4">R$ {tool.preco_venda.toFixed(2)}</td>
                          <td className="py-3 px-4 text-center">
                            <span
                              className={`px-3 py-1 rounded-full text-sm font-medium ${
                                isLow
                                  ? "bg-red-100 text-red-800"
                                  : isExcess
                                    ? "bg-yellow-100 text-yellow-800"
                                    : "bg-green-100 text-green-800"
                              }`}
                            >
                              {currentStock}
                            </span>
                          </td>
                          <td className="py-3 px-4 text-sm">
                            {tool.estoque_minimo} / {tool.estoque_maximo}
                          </td>
                          <td className="py-3 px-4">
                            <div className="flex justify-center gap-2">
                              <Button variant="ghost" size="sm">
                                <Edit2 className="w-4 h-4" />
                              </Button>
                              <Button variant="ghost" size="sm">
                                <Trash2 className="w-4 h-4" />
                              </Button>
                            </div>
                          </td>
                        </tr>
                      )
                    })}
                  </tbody>
                </table>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </main>
  )
}
