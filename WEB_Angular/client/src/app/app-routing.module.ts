import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AppComponent } from "./app.component";
import { BudgetComponent } from "./budget/budget.component";
import { AboutComponent } from "./about/about.component";
import { EditComponent } from "./edit/edit.component";
import { MainComponent } from "./main/main.component";

const routes: Routes = [
  {
    path: '',
    redirectTo: '/main',
    pathMatch: 'full'
  },
  {
    path: 'main',
    component: MainComponent
  },
  {
    path: 'budget',
    component: BudgetComponent
  },
  {
    path: 'newBudget',
    component: EditComponent
  },
  {
    path: 'budget/:id',
    component: EditComponent
  },
  {
    path: 'about',
    component: AboutComponent
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }