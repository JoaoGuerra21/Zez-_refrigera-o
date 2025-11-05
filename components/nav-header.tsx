"use client"

import Link from "next/link"
import { useState } from "react"
import { Menu, X } from "lucide-react"

export function NavHeader() {
  const [isOpen, setIsOpen] = useState(false)

  return (
    <header className="sticky top-0 z-50 bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-lg">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16">
          <Link href="/" className="flex items-center gap-2 hover:opacity-90 transition">
            <span className="text-2xl">❄️</span>
            <span className="font-bold text-lg">Zezé Refrigeração</span>
          </Link>

          <nav className="hidden md:flex items-center gap-8">
            <Link href="/" className="hover:text-blue-100 transition">
              Início
            </Link>
            <Link href="/dashboard" className="hover:text-blue-100 transition">
              Dashboard
            </Link>
            <Link href="/dados" className="hover:text-blue-100 transition">
              Dados
            </Link>
            <Link href="/sobre" className="hover:text-blue-100 transition">
              Sobre
            </Link>
          </nav>

          <button className="md:hidden" onClick={() => setIsOpen(!isOpen)} aria-label="Toggle menu">
            {isOpen ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>

        {isOpen && (
          <nav className="md:hidden pb-4 space-y-2">
            <Link href="/" className="block py-2 hover:text-blue-100 transition">
              Início
            </Link>
            <Link href="/dashboard" className="block py-2 hover:text-blue-100 transition">
              Dashboard
            </Link>
            <Link href="/dados" className="block py-2 hover:text-blue-100 transition">
              Dados
            </Link>
            <Link href="/sobre" className="block py-2 hover:text-blue-100 transition">
              Sobre
            </Link>
          </nav>
        )}
      </div>
    </header>
  )
}
