"use client"

import { useState } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Badge } from "@/components/ui/badge"
import { NavHeader } from "@/components/nav-header"

interface Produto {
  id: number
  codigo: string
  nome: string
  marca: string
  preco_custo: number
  preco_venda: number
  margem_lucro: number
  estoque_atual: number
  status: string
}

interface Fornecedor {
  id: number
  nome: string
  cnpj: string
  telefone: string
  email: string
  prazo_entrega: number
}

interface Venda {
  id: number
  numero: string
  cliente: string
  valor: number
  data: string
  status: string
}

export default function DadosPage() {
  const [activeTab, setActiveTab] = useState("produtos")

  const produtos: Produto[] = [
    {
      id: 1,
      codigo: "GEL001",
      nome: "Geladeira Brastemp 400L",
      marca: "Brastemp",
      preco_custo: 1200,
      preco_venda: 1800,
      margem_lucro: 50,
      estoque_atual: 5,
      status: "Normal",
    },
    {
      id: 2,
      codigo: "GEL002",
      nome: "Geladeira Consul 340L",
      marca: "Consul",
      preco_custo: 900,
      preco_venda: 1350,
      margem_lucro: 50,
      estoque_atual: 8,
      status: "Normal",
    },
    {
      id: 3,
      codigo: "GEL003",
      nome: "Geladeira Electrolux 310L",
      marca: "Electrolux",
      preco_custo: 800,
      preco_venda: 1200,
      margem_lucro: 50,
      estoque_atual: 6,
      status: "Normal",
    },
    {
      id: 4,
      codigo: "FRZ001",
      nome: "Freezer Horizontal 411L",
      marca: "Metalfrio",
      preco_custo: 1100,
      preco_venda: 1650,
      margem_lucro: 50,
      estoque_atual: 3,
      status: "Baixo",
    },
    {
      id: 5,
      codigo: "FRZ002",
      nome: "Freezer Vertical 280L",
      marca: "Consul",
      preco_custo: 950,
      preco_venda: 1425,
      margem_lucro: 50,
      estoque_atual: 4,
      status: "Baixo",
    },
    {
      id: 6,
      codigo: "COMP001",
      nome: "Compressor 1/4 HP",
      marca: "Embraco",
      preco_custo: 180,
      preco_venda: 270,
      margem_lucro: 50,
      estoque_atual: 25,
      status: "Normal",
    },
    {
      id: 7,
      codigo: "COMP002",
      nome: "Compressor 1/3 HP",
      marca: "Embraco",
      preco_custo: 220,
      preco_venda: 330,
      margem_lucro: 50,
      estoque_atual: 18,
      status: "Normal",
    },
    {
      id: 8,
      codigo: "COMP003",
      nome: "Compressor 1/2 HP",
      marca: "Tecumseh",
      preco_custo: 280,
      preco_venda: 420,
      margem_lucro: 50,
      estoque_atual: 12,
      status: "Normal",
    },
    {
      id: 9,
      codigo: "ELE001",
      nome: "Termostato Universal",
      marca: "Danfoss",
      preco_custo: 45,
      preco_venda: 67.5,
      margem_lucro: 50,
      estoque_atual: 45,
      status: "Normal",
    },
    {
      id: 10,
      codigo: "ELE002",
      nome: "Timer Degelo 220V",
      marca: "Brastemp",
      preco_custo: 35,
      preco_venda: 52.5,
      margem_lucro: 50,
      estoque_atual: 32,
      status: "Normal",
    },
  ]

  const fornecedores: Fornecedor[] = [
    {
      id: 1,
      nome: "Embraco Compressores",
      cnpj: "12.345.678/0001-90",
      telefone: "(11) 3456-7890",
      email: "vendas@embraco.com",
      prazo_entrega: 5,
    },
    {
      id: 2,
      nome: "Consul Peças",
      cnpj: "23.456.789/0001-01",
      telefone: "(11) 2345-6789",
      email: "pecas@consul.com.br",
      prazo_entrega: 7,
    },
    {
      id: 3,
      nome: "Brastemp Componentes",
      cnpj: "34.567.890/0001-12",
      telefone: "(11) 3456-7891",
      email: "componentes@brastemp.com",
      prazo_entrega: 3,
    },
    {
      id: 4,
      nome: "Metalfrio Distribuidora",
      cnpj: "45.678.901/0001-23",
      telefone: "(11) 4567-8901",
      email: "vendas@metalfrio.com",
      prazo_entrega: 10,
    },
  ]

  const vendas: Venda[] = [
    { id: 1, numero: "VND001", cliente: "João Silva", valor: 1800, data: "2024-01-15", status: "Confirmada" },
    { id: 2, numero: "VND002", cliente: "Maria Santos", valor: 1200, data: "2024-01-16", status: "Confirmada" },
    { id: 3, numero: "VND003", cliente: "Pedro Costa", valor: 2500, data: "2024-01-17", status: "Confirmada" },
    { id: 4, numero: "VND004", cliente: "Ana Oliveira", valor: 1500, data: "2024-01-18", status: "Confirmada" },
    { id: 5, numero: "VND005", cliente: "Carlos Lima", valor: 3200, data: "2024-01-19", status: "Pendente" },
  ]

  const getStatusColor = (status: string) => {
    switch (status.toLowerCase()) {
      case "normal":
        return "bg-green-100 text-green-800"
      case "baixo":
        return "bg-yellow-100 text-yellow-800"
      case "crítico":
        return "bg-red-100 text-red-800"
      case "confirmada":
        return "bg-blue-100 text-blue-800"
      case "pendente":
        return "bg-orange-100 text-orange-800"
      default:
        return "bg-gray-100 text-gray-800"
    }
  }

  return (
    <>
      <NavHeader />
      <main className="min-h-screen bg-gradient-to-b from-blue-50 to-white dark:from-slate-950 dark:to-slate-900">
        <div className="bg-gradient-to-r from-blue-600 to-blue-700 text-white py-6 px-4 shadow-lg">
          <div className="container mx-auto">
            <h1 className="text-3xl font-bold mb-2">Visualização de Dados</h1>
            <p className="text-blue-100">Produtos, fornecedores e histórico de vendas da Zezé Refrigeração</p>
          </div>
        </div>

        <div className="container mx-auto p-6">
          <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
            <TabsList className="grid w-full grid-cols-3">
              <TabsTrigger value="produtos">Produtos ({produtos.length})</TabsTrigger>
              <TabsTrigger value="fornecedores">Fornecedores ({fornecedores.length})</TabsTrigger>
              <TabsTrigger value="vendas">Vendas ({vendas.length})</TabsTrigger>
            </TabsList>

            <TabsContent value="produtos" className="space-y-4">
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b bg-muted/50">
                      <th className="text-left p-3 font-semibold">Código</th>
                      <th className="text-left p-3 font-semibold">Produto</th>
                      <th className="text-left p-3 font-semibold">Marca</th>
                      <th className="text-right p-3 font-semibold">Custo</th>
                      <th className="text-right p-3 font-semibold">Venda</th>
                      <th className="text-right p-3 font-semibold">Margem</th>
                      <th className="text-right p-3 font-semibold">Estoque</th>
                      <th className="text-center p-3 font-semibold">Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    {produtos.map((produto) => (
                      <tr key={produto.id} className="border-b hover:bg-muted/50">
                        <td className="p-3 font-mono text-xs">{produto.codigo}</td>
                        <td className="p-3 font-medium">{produto.nome}</td>
                        <td className="p-3">{produto.marca}</td>
                        <td className="p-3 text-right">R$ {produto.preco_custo.toFixed(2)}</td>
                        <td className="p-3 text-right">R$ {produto.preco_venda.toFixed(2)}</td>
                        <td className="p-3 text-right text-green-600 font-semibold">
                          {produto.margem_lucro.toFixed(0)}%
                        </td>
                        <td className="p-3 text-right font-semibold">{produto.estoque_atual}</td>
                        <td className="p-3 text-center">
                          <Badge className={getStatusColor(produto.status)}>{produto.status}</Badge>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </TabsContent>

            <TabsContent value="fornecedores" className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {fornecedores.map((fornecedor) => (
                  <Card key={fornecedor.id}>
                    <CardHeader>
                      <CardTitle className="text-lg">{fornecedor.nome}</CardTitle>
                      <CardDescription>CNPJ: {fornecedor.cnpj}</CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-2">
                      <div>
                        <p className="text-sm text-muted-foreground">Telefone</p>
                        <p className="font-semibold">{fornecedor.telefone}</p>
                      </div>
                      <div>
                        <p className="text-sm text-muted-foreground">Email</p>
                        <p className="font-semibold">{fornecedor.email}</p>
                      </div>
                      <div>
                        <p className="text-sm text-muted-foreground">Prazo de Entrega</p>
                        <p className="font-semibold">{fornecedor.prazo_entrega} dias</p>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            </TabsContent>

            <TabsContent value="vendas" className="space-y-4">
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b bg-muted/50">
                      <th className="text-left p-3 font-semibold">Venda</th>
                      <th className="text-left p-3 font-semibold">Cliente</th>
                      <th className="text-right p-3 font-semibold">Valor</th>
                      <th className="text-left p-3 font-semibold">Data</th>
                      <th className="text-center p-3 font-semibold">Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    {vendas.map((venda) => (
                      <tr key={venda.id} className="border-b hover:bg-muted/50">
                        <td className="p-3 font-mono text-xs">{venda.numero}</td>
                        <td className="p-3 font-medium">{venda.cliente}</td>
                        <td className="p-3 text-right font-semibold text-green-600">R$ {venda.valor.toFixed(2)}</td>
                        <td className="p-3">{venda.data}</td>
                        <td className="p-3 text-center">
                          <Badge className={getStatusColor(venda.status)}>{venda.status}</Badge>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </TabsContent>
          </Tabs>
        </div>
      </main>
    </>
  )
}
