<?php

namespace App\Controller;


use App\Entity\Supplier;
use App\Form\SupplierType;
use App\Repository\SupplierRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/supplier")
 */
#[Route('/supplier')]
class SupplierController extends AbstractController
{
    /**
     * @Route("/supplier", name="supplier_index", methods={"GET"})
     */
    #[Route('/', name: 'app_supplier')]
    public function index(SupplierRepository $supplierRepository): Response
    {
        $suppliers = $supplierRepository->findAll();

        return $this->render('supplier/index.html.twig', [
            'suppliers' => $suppliers,
        ]);
    }

    /**
     * @Route("/supplier/new", name="supplier_new", methods={"GET", "POST"})
     */
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $supplier = new Supplier();
        $form = $this->createForm(SupplierType::class, $supplier);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($supplier);
            $entityManager->flush();

            return $this->redirectToRoute('app_supplier');
        }

        return $this->render('supplier/new.html.twig', [
            'supplier' => $supplier,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/supplier/{id}", name="supplier_show", methods={"GET"})
     */
    public function show(Supplier $supplier): Response
    {
        return $this->render('supplier/show.html.twig', [
            'supplier' => $supplier,
        ]);
    }

    /**
     * @Route("/supplier/{id}/edit", name="supplier_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Supplier $supplier, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(SupplierType::class, $supplier);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            return $this->redirectToRoute('app_supplier', [
                'id' => $supplier->getId(),
            ]);
        }

        return $this->render('supplier/edit.html.twig', [
            'supplier' => $supplier,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/supplier/{id}", name="supplier_delete", methods={"POST"})
     */
    public function delete(Request $request, Supplier $supplier, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$supplier->getId(), $request->request->get('_token'))) {
            $entityManager->remove($supplier);
            $entityManager->flush();
        }

        return $this->redirectToRoute('app_supplier');
    }
}
