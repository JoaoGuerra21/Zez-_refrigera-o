"use client"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"

interface Product {
  id: number
  codigo: string
  nome: string
  marca: string
  modelo: string
  preco_custo: number
  preco_venda: number
  margem_lucro: number
  categoria: string
  estoque_atual: number
  estoque_minimo: number
}

interface Fornecedor {
  id: number
  nome: string
  cnpj: string
  telefone: string
  email: string
  prazo_entrega_dias: number
  condicoes_pagamento: string
}

interface Venda {
  id: number
  numero_venda: string
  cliente_nome: string
  valor_final: number
  data_venda: string
  status: string
}

const mockProducts: Product[] = [
  {
    id: 1,
    codigo: "GEL001",
    nome: "Geladeira Brastemp 400L Duplex",
    marca: "Brastemp",
    modelo: "BRM54HK",
    preco_custo: 1200.0,
    preco_venda: 1800.0,
    margem_lucro: 50.0,
    categoria: "Geladeiras",
    estoque_atual: 5,
    estoque_minimo: 2,
  },
  {
    id: 2,
    codigo: "GEL002",
    nome: "Geladeira Consul 340L",
    marca: "Consul",
    modelo: "CRA39AB",
    preco_custo: 900.0,
    preco_venda: 1350.0,
    margem_lucro: 50.0,
    categoria: "Geladeiras",
    estoque_atual: 8,
    estoque_minimo: 3,
  },
  {
    id: 3,
    codigo: "COMP001",
    nome: "Compressor 1/4 HP R134a",
    marca: "Embraco",
    modelo: "EMI60HER",
    preco_custo: 180.0,
    preco_venda: 270.0,
    margem_lucro: 50.0,
    categoria: "Peças Compressor",
    estoque_atual: 25,
    estoque_minimo: 10,
  },
  {
    id: 4,
    codigo: "ELE001",
    nome: "Termostato Universal",
    marca: "Danfoss",
    modelo: "RC1075",
    preco_custo: 45.0,
    preco_venda: 67.5,
    margem_lucro: 50.0,
    categoria: "Peças Elétricas",
    estoque_atual: 45,
    estoque_minimo: 20,
  },
]

const mockFornecedores: Fornecedor[] = [
  {
    id: 1,
    nome: "Embraco Compressores",
    cnpj: "12.345.678/0001-90",
    telefone: "(11) 3456-7890",
    email: "vendas@embraco.com",
    prazo_entrega_dias: 5,
    condicoes_pagamento: "30 dias",
  },
  {
    id: 2,
    nome: "Consul Peças",
    cnpj: "23.456.789/0001-01",
    telefone: "(11) 2345-6789",
    email: "pecas@consul.com.br",
    prazo_entrega_dias: 7,
    condicoes_pagamento: "45 dias",
  },
]

const mockVendas: Venda[] = [
  {
    id: 1,
    numero_venda: "VENDA001",
    cliente_nome: "João Silva",
    valor_final: 1800.0,
    data_venda: "2024-01-15",
    status: "CONFIRMADO",
  },
  {
    id: 2,
    numero_venda: "VENDA002",
    cliente_nome: "Maria Santos",
    valor_final: 2700.0,
    data_venda: "2024-01-16",
    status: "ENTREGUE",
  },
]

function getEstoqueStatus(atual: number, minimo: number) {
  if (atual <= minimo) return { label: "CRÍTICO", variant: "destructive" }
  if (atual <= minimo * 1.5) return { label: "BAIXO", variant: "secondary" }
  return { label: "NORMAL", variant: "default" }
}

export function DataViewer() {
  return (
    <div className="w-full space-y-6">
      <Tabs defaultValue="produtos" className="w-full">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="produtos">Produtos</TabsTrigger>
          <TabsTrigger value="fornecedores">Fornecedores</TabsTrigger>
          <TabsTrigger value="vendas">Vendas</TabsTrigger>
        </TabsList>

        <TabsContent value="produtos" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Produtos em Estoque</CardTitle>
              <CardDescription>Listagem completa de produtos com preços e quantidades</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Código</TableHead>
                      <TableHead>Nome</TableHead>
                      <TableHead>Marca</TableHead>
                      <TableHead>Custo</TableHead>
                      <TableHead>Venda</TableHead>
                      <TableHead>Margem</TableHead>
                      <TableHead>Estoque</TableHead>
                      <TableHead>Status</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {mockProducts.map((product) => {
                      const status = getEstoqueStatus(product.estoque_atual, product.estoque_minimo)
                      return (
                        <TableRow key={product.id}>
                          <TableCell className="font-mono text-sm">{product.codigo}</TableCell>
                          <TableCell className="font-medium">{product.nome}</TableCell>
                          <TableCell>{product.marca}</TableCell>
                          <TableCell>R$ {product.preco_custo.toFixed(2)}</TableCell>
                          <TableCell>R$ {product.preco_venda.toFixed(2)}</TableCell>
                          <TableCell>{product.margem_lucro.toFixed(1)}%</TableCell>
                          <TableCell className="text-center font-semibold">
                            {product.estoque_atual} / {product.estoque_minimo}
                          </TableCell>
                          <TableCell>
                            <Badge variant={status.variant as any}>{status.label}</Badge>
                          </TableCell>
                        </TableRow>
                      )
                    })}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="fornecedores" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Fornecedores Cadastrados</CardTitle>
              <CardDescription>Lista de fornecedores com informações de contato</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {mockFornecedores.map((fornecedor) => (
                  <Card key={fornecedor.id} className="bg-gray-50 dark:bg-gray-900">
                    <CardContent className="pt-6">
                      <div className="space-y-2">
                        <div>
                          <p className="text-sm text-muted-foreground">Nome</p>
                          <p className="font-semibold">{fornecedor.nome}</p>
                        </div>
                        <div>
                          <p className="text-sm text-muted-foreground">CNPJ</p>
                          <p className="font-mono">{fornecedor.cnpj}</p>
                        </div>
                        <div>
                          <p className="text-sm text-muted-foreground">Contato</p>
                          <p>{fornecedor.telefone}</p>
                          <p className="text-sm">{fornecedor.email}</p>
                        </div>
                        <div className="grid grid-cols-2 gap-2">
                          <div>
                            <p className="text-sm text-muted-foreground">Prazo Entrega</p>
                            <p className="font-semibold">{fornecedor.prazo_entrega_dias} dias</p>
                          </div>
                          <div>
                            <p className="text-sm text-muted-foreground">Pagamento</p>
                            <p className="font-semibold">{fornecedor.condicoes_pagamento}</p>
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="vendas" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Histórico de Vendas</CardTitle>
              <CardDescription>Vendas realizadas e seus detalhes</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Nº Venda</TableHead>
                      <TableHead>Cliente</TableHead>
                      <TableHead>Data</TableHead>
                      <TableHead>Valor</TableHead>
                      <TableHead>Status</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {mockVendas.map((venda) => (
                      <TableRow key={venda.id}>
                        <TableCell className="font-mono">{venda.numero_venda}</TableCell>
                        <TableCell>{venda.cliente_nome}</TableCell>
                        <TableCell>{new Date(venda.data_venda).toLocaleDateString("pt-BR")}</TableCell>
                        <TableCell className="font-semibold">R$ {venda.valor_final.toFixed(2)}</TableCell>
                        <TableCell>
                          <Badge variant={venda.status === "ENTREGUE" ? "default" : "secondary"}>{venda.status}</Badge>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  )
}
